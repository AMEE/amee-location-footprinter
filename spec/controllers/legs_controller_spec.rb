require 'spec_helper'

describe LegsController do

  def new_uuid
    UUIDTools::UUID.random_create.to_s.gsub('-', '')
  end

  context "viewing journeys after signed in" do

  use_vcr_cassette "creating_legs_from_checkins", :record => :once

    before(:each) do
      # setup our user via foursquare here, so the next request doesn't
      # 302 you around
      session["access_token"] = Rails.configuration.foursquare_access_token

      foursquare = Foursquare::Base.new(session[:access_token])
      foursquare_user = foursquare.users.find('self')

      u = User.find_or_create_by_foursquare_id(foursquare_user.id.to_i)
      @user = u
      u.update_attributes!({
        :email => foursquare_user.email,
        :name => foursquare_user.name,
        :foursquare_id => foursquare_user.id.to_i,
        :last_email_sent => Date.current - 8.day,
        :token => session[:access_token]
      })

      
      # build some checkins - if user has reached this point, they already to have them
      # build checkins

      @first_checkin  = FactoryGirl.create(:checkin, :user => u, :foursquare_id => new_uuid, :timestamp => 1.day.ago)
      @second_checkin = FactoryGirl.create(:checkin, :user => u, :foursquare_id => new_uuid, :timestamp => 23.hours.ago)
      @third_checkin  = FactoryGirl.create(:checkin, :user => u, :foursquare_id => new_uuid, :timestamp => 47.hours.ago)
      @fourth_checkin = FactoryGirl.create(:checkin, :user => u, :foursquare_id => new_uuid, :timestamp => 2.days.ago)
      @fifth_checkin  = FactoryGirl.create(:checkin, :user => u, :foursquare_id => new_uuid, :timestamp => 70.hours.ago)
      @sixth_checkin  = FactoryGirl.create(:checkin, :user => u, :foursquare_id => new_uuid, :timestamp => 3.days.ago)
      
      # binding.pry
      
      @first_leg = FactoryGirl.create(:leg, :start_checkin => @first_checkin, :end_checkin => @second_checkin, :user => u, :timestamp => @first_checkin.timestamp)
      @second_leg = FactoryGirl.create(:leg, :start_checkin => @second_checkin, :end_checkin => @third_checkin, :user => u, :timestamp => @second_checkin.timestamp) 
      @third_leg = FactoryGirl.create(:leg, :start_checkin => @third_checkin, :end_checkin => @fourth_checkin, :user => u, :timestamp => @third_checkin.timestamp)

      # binding.pry      

    end

    it "shows all the journeys from the last week" do
      # setup up user
      get "index"

      response.should be_successful

      assigns[:legs].should_not be_empty
      # A day with checkins should have corresponding entries assigned…
      assigns[:days][:saturday].should_not be_empty
      # And a day without should not.
      assigns[:days][:monday].should be_empty
    end

    it "shows a single journey's detail view" do
      # as long as we're visiting one leg,
      # it doesn't matter which one
      get "show", :id => Leg.first.id

      response.should be_successful
      assigns.should have_key :leg
      assigns[:leg].should be_a Leg


      
    end

  end

end
