Feature: Administrator must log in to get to Homophone Maintenance screen
  Scenario: Login prompted if not already logged in
    Given I am not logged in
    When I go to the homophone maintenance page
    Then I should see "Login Required"
    
  Scenario: Login page displays request for credentials
    Given I am not logged in as an admin
    When I go to the admin login page
    Then I should see "Login Required"
    
  Scenario: Redirected to Maintenance page after login
    When I log in as admin
    Then I should see "Homophone Administration Page"
    
  Scenario: Still on login page if login failed
    When I log in as admin with wrong credentials
    Then I should see "Login Required"

## we want to verify that you can only access the question/quiz creation page if you are admin