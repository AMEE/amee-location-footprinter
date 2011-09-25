require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the FootprintHelper. For example:
#
describe FootprintsHelper do  
    
  it "should give the distance between two latlngs, using the haversine formula" do
    checkin1 = FactoryGirl.build(:checkin, :lat => "51.514667", :lon => "-0.136047") # Off Broadway Bar, London
    checkin2 = FactoryGirl.build(:checkin, :lat => "51.502557", :lon => "-0.07253941") # The Marksman Pub, London
    helper.distance_between_points(checkin1, checkin2).to_meters.should be_within(0.1).of(4596.84510626154)
  end
  
  use_vcr_cassette "fetching_carbon_for_walking"
  it "should calculate distances up to 1km based on CO2 from walking" do
    # create two checkins using the factories
    checkin1 = FactoryGirl.build(:checkin, :lat => "51.514667", :lon => "-0.136047") # Off Broadway Bar, London
    checkin2 = FactoryGirl.build(:checkin, :lat => "51.502557", :lon => "-0.07253941") # The Marksman Pub, London  

    # fetch the distance
    distance = helper.distance_between_points(checkin1, checkin2)
    
    distance.to_meters.should be_within(0.1).of(4596.84510626154)

    # fetch the carbon 
    helper.co2_for_km(distance.to_meters)

    helper.should_receive(:carbon_for_car).with(distance.to_meters).and_return(0.940468540290048)

  end

  use_vcr_cassette "fetching_carbon_for_driving"
  it "should calculate distances of between 1km and 200km based on CO2 from driving" do
    pending
  end

  use_vcr_cassette "fetching_carbon_for_domestic_flights"    
  it "should calculate distances of between 1km and 200km based on CO2 for domestic flights" do
    pending
  end
  
  use_vcr_cassette "fetching_carbon_for_international_flights"        
  it "should calculate distances upto 1km based on CO2 based on CO2 for international flights" do
    pending
  end
  
  
  
end
