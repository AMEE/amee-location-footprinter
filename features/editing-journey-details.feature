Feature: Editing my journeys

  As a user
  I want sign in into the AMEE app with my foursquare credentials
  And update assumptions about my journey method
  So that I can see the footprint of my travel

  @wip
  Scenario: Seeing my own checkins
    And sign in via Foursquare
    When I visit the home page
    Then I should see a list of checkins