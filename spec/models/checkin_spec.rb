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
    @checkin = FactoryGirl.build(:checkin, :timezone => "")
    @checkin.save
    @checkin.should_not be_valid
  end

  it "should have a timezone from foursqure" do
    @checkin = FactoryGirl.build(:checkin, :timestamp => "")
    @checkin.save
    @checkin.should_not be_valid
  end

end