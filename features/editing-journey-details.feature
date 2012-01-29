Feature: Editing my journeys

  As a user
  I want sign in into the AMEE app with my foursquare credentials
  And update assumptions about my journey method
  So that I can see the footprint of my travel

  @wip
Scenario: Seeing my own checkins
  When I visit the home page
  And sign in via Foursquare
  Then I should see a list of checkins