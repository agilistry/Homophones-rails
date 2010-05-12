Feature: Create homophone set

  Scenario: Creating a new homophone set displays set on main list
    Given there are no homophone sets
    When I create a homophone set with the following words:
      | name | definition |
      | to | participle |
      | two | one more than one |
      | too | also |
    And I go to the homophone list page
    Then I see 1 set of 3 homophones
    And the homophones are in order: "to", "too", and "two"
    And each word has a definition
    