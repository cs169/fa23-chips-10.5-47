Feature: display representatives after clicking on a county from the map

  As a politically active user
  So that I can learn more about political candidates in my county
  I want to see a list of representatives when I click on my county from the map

Background: states and counties have been added to the database

  Given the following states exist:
    | name       | symbol | fips_code | is_territory | lat_min     | lat_max     | long_min  | long_max    |
    | California | CA     | 06        | 0            | -124.409591 | -114.131211 | 32.534156 | -114.131211 |
    | Nevada     | NV     | 32        | 0            | -120.005746 | -114.039648 | 35.001857 | -114.039648 |

  And the following counties in California exist:
    | name                 | fips_code | fips_class |
    | Alameda County       | 001       | H1         |
    | San Francisco County | 075       | H6         |

Scenario: view representatives by county
  Given I'm on the California page
  When I click Alameda County
  Then I should see Henry C. Levy's name