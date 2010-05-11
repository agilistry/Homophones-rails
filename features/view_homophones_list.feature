Feature: View homophone list
  Scenario: View homophone list
    When I go to the homophone list page
    Then I should see "short little word"

  Scenario: Navigate by first letter
    Given we have a homophone set "a, eh"
    When I go to the homophone list page
    Then I should see a link called "A"
    And I should not see a link called "B"


