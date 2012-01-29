require 'spec_helper'

describe LegsController do

  context "viewing journeys after signed in" do

    before(:each) do
      # setup our user via foursquare here, so the next request doesn't
      # 302 you around
      session["access_token"] = Rails.configuration.foursquare_access_token
    end

    it "shows all the journeys from the last week, grouped by day" do
      # setup up user

      get "index"
      # binding.pry
      response.should be_successful
    end

    it "shows all a single journey's detail view" do
      

      
    end

  end

end
