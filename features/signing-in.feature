Feature: Signing in with OAuth

  As a user
  I want sign in into the AMEE app with my foursquare credentials
  So that I can see the footprint of my travel

  Scenario: Login via Foursquare
    When I visit the home page
    Then I should see my name