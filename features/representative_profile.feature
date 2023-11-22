Feature: display a representative's profile page

  As a politically active user
  So that I can learn more about particular political candidates
  I want to see info about representatives, such as their name, OCD ID, title, political party, contact address, and photo

Background: representatives have been added to the database

  Given Goodwin H. Liu exists

Scenario: view representative's profile
  When I visit Goodwin H. Liu's profile page
  Then I should see Goodwin H. Liu's name
  And I should see Goodwin H. Liu's OCD ID
  And I should see Goodwin H. Liu's title
  And I should see Goodwin H. Liu's contact address
  And I should see Goodwin H. Liu's political party
  And I should see Goodwin H. Liu's photo

Scenario: access representative's profile from search
  When I visit the representatives search page
  And I search with a California address
  And I click on Goodwin H. Liu's profile in the search results
  Then I should see Goodwin H. Liu's profile

Scenario: access representative's profile from news items
  Given a news item about Goodwin H. Liu exists
  When I visit Goodwin H. Liu's news items page
  And I click on Info button of the first news item
  And I click on Goodwin H. Liu's profile in the news item page
  Then I should see Goodwin H. Liu's profile
