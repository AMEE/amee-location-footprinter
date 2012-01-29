When /^sign in via Foursquare$/ do

  # following accordingly - http://technicalpickles.com/posts/capybara-and-domains/
  # Make request to fetch user details, passing along auth token.
  # Create user on system using deets
  VCR.use_cassette("foursquare/sign_in", :record => :all) do

    visit footprints_user_url
  end





end