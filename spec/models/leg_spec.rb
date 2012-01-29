require 'spec_helper'

describe Leg do

  # set up a user, then two checkins then a single leg
  # TODO why is this error occuring here? These methods should surely be availble if 
  # they're used in Checkin#calculate_carbon_and_send_mail to create new legs

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
end
