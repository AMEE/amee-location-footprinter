require 'spec_helper'

describe Leg do

  # set up a user, then two checkins then a single leg
  it "should have a beginning checkin" do
    pending
  end

  it "should have an arrival checkin" do
    pending
  end

  it "should have distance between checkins" do
    @leg = FactoryGirl.build(:leg, :distance => "")
    @leg.save
    @leg.should_not be_valid
  end
  it "should have a CO2 footprint" do
    @leg = FactoryGirl.build(:leg, :co2 => "")
    @leg.save
    @leg.should_not be_valid
  end
end
