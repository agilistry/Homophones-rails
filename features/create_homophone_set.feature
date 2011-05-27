Feature: Create homophone set
  Background:
    Given I log in as admin
    And there are no homophone sets

  Scenario: Creating a new homophone set displays set on main list
    When I create a homophone set with the following words:
      | name | definition          |
      | to   | a short little word |
      | two  | one more than one   |
      | too  | also                |
    And I go to the home page
    Then I see 1 set of 3 homophones each
    And the homophones are in order: "to, too, two"
    And each word has a definition

  Scenario: System displays error when no homophones are submitted
    When I create a homophone set with the following words:
      | name | definition |
      |      |            |
    Then I see the error "Please create at least 2 homophones for a complete set"
    And there are 0 homophone sets

  Scenario: System displays error when 1 homophone is submitted
    When I create a homophone set with the following words:
      | name | definition          |
      | to   | a short little word |
    Then I see the error "Please create at least 2 homophones for a complete set"
    And there are 0 homophone sets

  Scenario: System accepts words without definitions
    When I create a homophone set with the following words:
      | name | definition          |
      | to   | a short little word |
      | too  |                     |
    And there is 1 homophone set

  Scenario: System displays error when homophone submitted without word
    When I create a homophone set with the following words:
      | name | definition          |
      | to   | a short little word |
      |      | also                |
    Then I see the error "Please enter the missing word"
    And there are 0 homophone sets

  Scenario: System displays multiple errors if applicable
    When I create a homophone set with the following words:
      | name | definition |
      |      | also       |
    Then I see the error "Please enter the missing word"
    And I see the error "Please create at least 2 homophones for a complete set"
    And there are 0 homophone sets

  Scenario: Words with apostrophes within homsets are in the correct order
    When I create a homophone set with the following words:
      | name   | definition                                     |
      | men's  | not women's                                    |
      | mends  | fixes                                          |
    And I go to the home page
    And the homophones are in order: "mends, men's"
    
  Scenario: Words with caps within homsets are in the correct order
    When I create a homophone set with the following words:
      | name   | definition                                     |
      | URL  | fixes                                          |
      | e'er  | not women's                                    |
      | earl  | belonging to more than one guy                 |
    And I go to the home page
    And the homophones are in order: "earl, e'er, URL"
    
    
