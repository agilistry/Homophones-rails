Feature: Simple Search
  In order to find sets of homophones by searching for a word in the homophone set
  Nancy wants to enter a work in a homophone set to find the whole set

  Scenario: Searching results in 1 set
    Given we have a homophone set:
    |name| definition |
    |a| short little word |
    |eh| interrogative |
    And we have a homophone set:
    |name|
    |acts|
    |ax|
    When I go to the homophone list page
    And I fill in "Search" with "eh"
    And I press "Go"
    Then I should be on the search homophone sets page
    And I should see a homophone set that contains "a"
    And I should see "short little word"
    And I should not see "acts"

  Scenario: Searching results in 0 sets
    When I go to the homophone list page
    And I fill in "Search" with "eh"
    And I press "Go"
    Then I should be on the search homophone sets page
    And I should see "There are no homophones that match eh"



