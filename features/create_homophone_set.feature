@wip
Feature: Create homophone set
  Background:
    Given the administrator user name is "admin" with password "password"
    And I log in with "admin" / "password"
    And there are no homophone sets

  Scenario: Creating a new homophone set displays set on main list
    When I create a homophone set with the following words:
      | name | definition          |
      | to   | a short little word |
      | two  | one more than one   |
      | too  | also                |
    And I go to the homophone list page
    Then I see 1 set of 3 homophones
    And the homophones are in order: "to, too, two"
    And each word has a definition

  Scenario: System displays error when no homophones are submitted
    When I create a homophone set with the following words:
      | name | definition |
      |      |            |
    Then I see the error "Please create at least 2 homophones for a complete set"
    And there are 0 homophone sets

  Scenario: System displays error when 1 homophone is submitted
    Given wip
    When I create a homophone set with the following words:
      | name | definition          |
      | to   | a short little word |
    Then I see the error "Please create the second homophone to complete the set"
    And there are 0 homophone sets

  Scenario: System displays error when homophone submitted without definition
    Given wip
    When I create a homophone set with the following words:
      | name | definition          |
      | to   | a short little word |
      | too  |                     |
    Then I see the error "Please enter the missing definition"
    And there are 0 homophone sets

  Scenario: System displays error when homophone submitted without word
    Given wip
    When I create a homophone set with the following words:
      | name | definition          |
      | to   | a short little word |
      |      | also                |
    Then I see the error "Please enter the missing word"
    And there are 0 homophone sets

  Scenario: System displays multiple errors if applicable
    Given wip
    When I create a homophone set with the following words:
      | name | definition |
      | to   |            |
      |      | also       |
    Then I see the error "Please enter the missing word"
    Then I see the error "Please enter the missing definition"
    And I see the error "Please create the second homophone to complete the set"
    And there are 0 homophone sets
