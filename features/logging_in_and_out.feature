Feature: Logging in and out
  Background:
    Given the confirmed user:
      | email           | password | first_name | last_name |
      | joe@example.com | password | Joe        | Example   |

  Scenario: Logging in shows user's full name and a log out link
    Given I am not logged in
    When I go to the home page
    And I follow "Log in"
    And I log in with "joe@example.com" / "password"
    Then I should not see "Signed in successfully."
    And I should see "Joe Example"

  Scenario: Logging out shows a log in link
    Given I go to the home page
    And I follow "Log in"
    And I log in with "joe@example.com" / "password"
    And I follow "Log out"
    Then I should not see "Signed out successfully."
    And I should not see "Joe Example"