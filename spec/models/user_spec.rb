require 'spec_helper'

describe User do

  it "should have an email address" do
    @user = FactoryGirl.build(:user, :email => "")
    @user.save
    @user.should_not be_valid
  end

  it "should have a foursquare_id token" do
    @user = FactoryGirl.build(:user, :foursquare_id => "")
    @user.save
    @user.should_not be_valid
  end

  it "should have an name" do
    @user = FactoryGirl.build(:user, :name => "")
    @user.save
    @user.should_not be_valid
  end

  it "should record when the last email was sent to them" do
    # using Rails date extensions         
    # http://guides.rubyonrails.org/active_support_core_extensions.html#extensions-to-date
    last_week = Date.current - 7.day
    @user = Factory(:user, :last_email_sent => last_week)
    Factory :checkin, :user => @user 
    # freeze time, so we can test for it later
    Timecop.freeze(Date.current)

    # send an email
    FootprintMailer.footprint_email(@user)

    # we should have the new time as the frozen value, because time works 
    # like a global in Ruby
    @user.last_email_sent.should eq DateTime.now
  end





end
