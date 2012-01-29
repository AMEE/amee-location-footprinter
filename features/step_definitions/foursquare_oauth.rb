When /^sign in via Foursquare$/ do

  # following accordingly - http://technicalpickles.com/posts/capybara-and-domains/
  # Make request to fetch user details, passing along auth token.
  # Create user in the system by stubbing out the session in env.rb, and 
  # passing to the user url, where current user is created
  VCR.use_cassette("foursquare/sign_in", :record => :once) do
    visit footprints_user_url
  end
end

Then /^I should see my name$/ do
  page.document.has_content? "Chris"
end