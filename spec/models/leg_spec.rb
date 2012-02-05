require 'spec_helper'

describe Leg do

  # set up a user, then two checkins then a single leg

  it "should have a beginning checkin" do
    # pending
    @checkin2 = FactoryGirl.build(:checkin)
    @leg = FactoryGirl.build(:leg, :start_checkin => nil, :end_checkin => @checkin2)
    @leg.save
    @leg.should_not be_valid
  end

  it "should have an arrival checkin" do
    @checkin2 = FactoryGirl.build(:checkin), 
    @leg = FactoryGirl.build(:leg, :start_checkin => @checkin2, :end_checkin => nil)
    @leg.save
    @leg.should_not be_valid
  end

  it "should have distance between checkins" do
    @leg = FactoryGirl.build(:leg, :distance => "")
    @leg.save
    @leg.should_not be_valid
  end

  it "should have a name" do
    @leg = FactoryGirl.build(:leg, :name => "")
    @leg.save
    @leg.should_not be_valid
  end

  it "should have a co2 reading" do
    @leg = FactoryGirl.build(:leg, :co2 => nil)
    @leg.save
    @leg.should_not be_valid
  end

  it "should have a mode of transport" do
    @leg = FactoryGirl.build(:leg, :mode_of_transport => nil)
    @leg.save
    @leg.should_not be_valid
  end

  it "allows recalculations" do
    @checkin1 = FactoryGirl.create(
      :checkin, 
      :lat => "51.5302391808239", 
      :lon => "-0.190415382385254", 
      :id => 10
    )
    @checkin2 = FactoryGirl.create(
      :checkin, :lat => "51.5917302346968", 
      :lon => "-0.069644669476303", 
      :id => 11,
      :foursquare_id => "4dde05bc1f6e0369473a10fb"
    )
    @leg = FactoryGirl.create(:leg, 
      :mode_of_transport => "car", 
      :end_checkin => @checkin1, 
      :start_checkin => @checkin2, 
      :distance => "not set"
    )
    @leg.distance.should == "not set"
    @leg.recalculate_distance!
    @leg.distance.should be_within(0.1).of 10.7912288632373

  end




end
