require 'spec_helper'

describe FootprintsController do

  describe "GET 'user'" do
    use_vcr_cassette "fetching_checkins_and_carbon"
    it "should fetch content from foursquare and amee" do
      # this is a working API token for Chris Adams - YMMV
      session["access_token"] = "GLW4QILQIABBXXTVOIR4FG25YXXPXVEMCF4V2A22GFBGUD2P"


      # mock out calls to quimby
      flexmock(Foursquare::Base).new_instances do |foursquare|
        foursquare.should_receive(:find).with(:self)
      end


      # mock out calls to AMEE abstraction layer
      flexmock(AMEE::DataAbstraction::OngoingCalculation).new_instances do |mock|
        mock.should_receive(:choose).and_return(nil)
        mock.should_receive(:calculate!).and_return(nil)
        mock.should_receive(:[]).with(:co2e).and_return(flexmock(:value => 42))
      end

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
