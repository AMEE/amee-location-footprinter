Feature: Signing in with OAuth

  As an admin
  I want sign in into the AMEE app with my foursquare credentials
  So that I can see the footprint of my travel

@mechanize, @vcr
Scenario: Login via Foursquare
  When I visit the admin page
  And sign in via Foursquare
  And Foursquare authorizes me
  Then I should see "admin"
  
