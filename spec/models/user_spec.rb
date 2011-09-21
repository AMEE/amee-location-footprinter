require 'spec_helper'

describe User do

  it "should have an email address" do
    @user = FactoryGirl.build(:user, :email => "")
    @user.save
    @user.should_not be_valid
  end

  it "should have an auth token" do
    @user = FactoryGirl.build(:user, :token => "")
    @user.save
    @user.should_not be_valid
  end

  it "should have an name" do
    @user = FactoryGirl.build(:user, :name => "")
    @user.save
    @user.should_not be_valid
  end





end
