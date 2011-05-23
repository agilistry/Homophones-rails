Feature: Edit homophone set
  Background:
    Given I am logged in as "admin"

  Scenario: Add a new word
    Given we have a homophone set:
      | name | definition        |
      | a    | short little word |
      | eh   | interrogative     |
    When I edit the homophone set containing "eh" to be:
      | name | definition              |
      | a    | short little word       |
      | eh   | something Canadians say |
      | ay   | New Jersey greeting     |
    And I go to the homophone list page
    Then the homophones are in order: "a, ay, eh"
    And each word has a definition
    And I should see "something Canadians say"
    And I should see "New Jersey greeting"

  Scenario: Fails with only 1 word
    Given we have a homophone set:
      | name | definition        |
      | a    | short little word |
      | eh   | interrogative     |
    When I edit the homophone set containing "eh" to be:
      | name | definition        |
      | a    | short little word |
    And I go to the homophone list page
    Then the homophones are in order: "a, eh"

  @wip
  Scenario: Fails with word name missing
    Given we have a homophone set:
      | name | definition        |
      | a    | short little word |
      | eh   | interrogative     |
    When I edit the homophone set containing "eh" to be:
      | name | definition              |
      | a    | short little word       |
      |      | something Canadians say |
    And I go to the homophone list page
    Then the homophones are in order: "a, eh"
