require 'spec_helper'

describe FootprintsController do

  describe "GET 'user'" do
    use_vcr_cassette "fetching_checkins_and_carbon"
    it "should fetch content from foursquare and amee" do
      # this is a working API token for Chris Adams - YMMV
      session["access_token"] = "GLW4QILQIABBXXTVOIR4FG25YXXPXVEMCF4V2A22GFBGUD2P"
      get 'user'
      response.should be_success
    end
    
    # <% 
    # unless (i == 0)
    #   puts i
    #   dist = distance_between_points(c, @user_checkins[i-1])
    # 
    #   puts number_with_precision(dist.to_km, :precision => 2)
    #   # carbon = carbon_for_distance(dist.to_km)
    #   carbon = 0
    #   puts carbon.to_s
    #   @total_co2 += carbon
    # end
    # %>  
    
  end

end
