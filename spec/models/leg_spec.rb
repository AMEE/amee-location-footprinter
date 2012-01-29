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




end
