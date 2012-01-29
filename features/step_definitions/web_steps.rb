When /^I visit the home page$/ do
  VCR.use_cassette("foursquare/home_page") do
    visit "/"
  end
end