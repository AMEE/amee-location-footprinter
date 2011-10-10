require 'spec_helper'

describe FootprintsController do

  describe "GET 'user'" do
    use_vcr_cassette "fetching_checkins_and_carbon"

    before(:each) do
      # this is a working API token for Chris Adams - it's passed into vcr,
      # so it knows what response to provide
      # for example, 
      session["access_token"] = "GLW4QILQIABBXXTVOIR4FG25YXXPXVEMCF4V2A22GFBGUD2P"


      # mock out calls to AMEE abstraction layer
      flexmock(AMEE::DataAbstraction::OngoingCalculation).new_instances do |mock|
        mock.should_receive(:choose).and_return(nil)
        mock.should_receive(:calculate!).and_return(nil)
        mock.should_receive(:[]).with(:co2e).and_return(flexmock(:value => 42))
      end

    end

    it "should fetch user details and checkins from foursquare" do

      get 'user'

      
      User.first should_not be_blank
      first_journey = User.first.legs.first

      # We should be able to fetch a checkin from the object by calling `end_checkin_id`
      end_checkin = first_journey.end_checkin
      start_checkin = first_journey.start_checkin

      # we should get back an object
      end_checkin.class.should == Checkin
      start_checkin.class.should == Checkin
      end_checkin.incoming_leg.should == first_journey
    end

    it "should forward the user to a thank you page" do

      # start the mocked out sign in process
      get 'user'
      User.count.should eq 1

      response.should redirect_to footprints_thanks_path
    end


  end

end
