require 'spec_helper'

describe Leg do

  # set up a user, then two checkins then a single leg
  # TODO why is this error occuring here? These methods should surely be availble if 
  # they're used in Checkin#calculate_carbon_and_send_mail to create new legs
  # 
  # # Failure/Error: @checkin1 = FactoryGirl.build(:checkin, :start_checkin_id => "")
  #        NoMethodError:
  #        undefined method `start_checkin_id=' for #<Checkin:0x105627fe0>
  #        ./spec/models/leg_spec.rb:7
  
  it "should have a beginning checkin" do
    pending
    @checkin1 = FactoryGirl.build(:checkin, :start_checkin => "") 
    @leg = FactoryGirl.build(:leg, :distance => "")
    @leg.save
    @leg.should_not be_valid

  end

  it "should have an arrival checkin" do
    pending
    @checkin1 = FactoryGirl.build(:checkin, :end_checkin => "") 
    @leg = FactoryGirl.build(:leg, :distance => "")
    @leg.save
    @leg.should_not be_valid
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
