When /^sign in via Foursquare$/ do

  # # following accordingly - http://technicalpickles.com/posts/capybara-and-domains/
  url = find('a.connect')['href']
  # binding.pry
  Typhoeus::Request.get(url)


end

When /^Foursquare authorizes me$/ do
  pending # express the regexp above with the code you wish you had
end