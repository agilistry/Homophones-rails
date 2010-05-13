@smoke
Feature: Log in as admin to the live site

  Scenario: Logging in shows administration page
    Given the secret admin credentials
    When I log in with the secret admin credentials
    Then I should see the admin page
