require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'callback'" do
    # this would normally mock the request for us to test the response, but:

    # 1) the stored result here is actually an error

    # 2) So much of these interactions are wrapped by quimby anyway,
    #   that I'm not sure of the value in testing the full back and 
    #   for between quimby and foursquare here, when all we care about is
    #   having an access code in our session to use for future requests
    use_vcr_cassette "fetching oauth token"
    it "should authenticate and send the user to the footprint controller " do
      get 'callback', {:code => "foursquare_code_string"}
      session.should_not be_empty
      # when running tests, this comes back as nil
      session.should have_key "access_token"
      response.should redirect_to(:controller => 'footprints', :action => 'user')
    end
  end

end
