require 'spec_helper'

describe Checkin do

  it "should have a latitude" do
    @checkin = FactoryGirl.build(:checkin, :lat => "")
    @checkin.save
    @checkin.should_not be_valid
  end

  it "should have a longitude" do
    @checkin = FactoryGirl.build(:checkin, :lon => "")
    @checkin.save
    @checkin.should_not be_valid
  end

  it "should have a foursquare_id" do
    @checkin = FactoryGirl.build(:checkin, :foursquare_id => "")
    @checkin.save
    @checkin.should_not be_valid
  end

  it "should have a venue name" do
    @checkin = FactoryGirl.build(:checkin, :venue_name => "")
    @checkin.save
    @checkin.should_not be_valid
  end

  it "should have a timestamp " do
    @checkin = FactoryGirl.build(:checkin, :timestamp => "")
    @checkin.save
    @checkin.should_not be_valid
  end

  it "should have a timezone from foursqure" do
    @checkin = FactoryGirl.build(:checkin, :timezone => "")
    @checkin.save
    @checkin.should_not be_valid
  end

  context "fetching CO2 readings when creating legs"

  it "should calculate distances up to 1km based on CO2 from walking" do
      # Mock out the model, so we check that we're making the correct calls
      # to the AMEE abstraction layer
      distance = 0.75
      flexmock(Checkin).should_receive(:carbon_for).with("walking", 0.75).once.and_return(0)
      Checkin.co2_for_km(distance).should eq 0
  end

  it "should calculate distances of between 1km and 200km based on CO2 from driving" do

    # create two checkins using the factories
    checkin1 = FactoryGirl.build(:checkin, :lat => "51.514667", :lon => "-0.136047") # Off Broadway Bar, London
    checkin2 = FactoryGirl.build(:checkin, :lat => "51.502557", :lon => "-0.07253941") # The Marksman Pub, London  

    # fetch the distance
    distance = Checkin.distance_between_points(checkin1, checkin2)
    distance.to_kilometers.should be_within(0.1).of(4.59684510626154)

    # Mock out the model, so we check that we're making the correct calls
    # to the AMEE abstraction layer
    flexmock(Checkin).should_receive(:carbon_for).with("car", distance.to_kilometers).once.and_return(42)

    Checkin.co2_for_km(distance.to_km).should eq 42
  end

  # TODO refactor these tests, to remove duplicated code
  # TODO make sure the short haul flight is calculated on quantity, not distance

  it "should calculate distances of between 200km and 1000km based on CO2 for domestic flights" do
    distance = 300
    flexmock(Checkin).should_receive(:carbon_for).with("domestic_flight", distance).once.and_return(300)
    Checkin.co2_for_km(distance).should eq 300
  end
  
  it "should calculate distances upto 1km based on CO2 for short_haul flights" do
    distance = 2000
    flexmock(Checkin).should_receive(:carbon_for).with("short_haul_flight", distance).once.and_return(300)
    Checkin.co2_for_km(distance).should eq 300
  end

  it "should calculate distances of more than 3000km based on CO2 from long haul flights" do
    # fetch the distance
    distance = 4000    
    flexmock(Checkin).should_receive(:carbon_for).with("long_haul_flight", distance).once.and_return(1000)
    Checkin.co2_for_km(distance).should eq 1000
  end

  it "should not calculate distances larger than the circumference of the planet" do |variable|
    distance = 40100
    # https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/raise-error-matcher
    expect { Checkin.co2_for_km(distance) }.to raise_error
    expect { Checkin.co2_for_km(distance) }.to raise_error(DistanceError)
  end

end