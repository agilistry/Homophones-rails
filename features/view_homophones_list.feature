Feature: View homophone list
  Scenario: View homophone list
    Given we have a homophone set:
      | name | definition        |
      | a    | short little word |
      | eh   | interrogative     |
    When I go to the homophone list page
    Then I should see "short little word"

  Scenario: Navigate by first letter
  Given we have a homophone set:
    | name | definition        |
    | a    | short little word |
    | eh   | interrogative     |
    When I go to the homophone list page
    Then I should see a link called "A"
    And I should not see a link called "B"
