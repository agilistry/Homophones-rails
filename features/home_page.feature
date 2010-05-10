Feature: Visiting the home page
  Scenario: Visiting home page
    Given I am on the home page
    Then I should see "Hello, Agilistry"

  Scenario: Greeting the user
    Given I am on the home page
    When I fill in "Name" with "Elisabeth"
    And I press "Greet"
    Then I should see "Hello, Elisabeth"