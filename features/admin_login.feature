Feature: Administrator must log in to get to Homophone Maintenance screen
  Scenario: Login prompted if not already logged in
    Given I am not logged in
    When I go to the homophone maintenance page
    Then I should see "Login Required"
    
  Scenario: Login page displays request for credentials
    Given I am not logged in
    When I go to the admin login page
    Then I should see "Login Required"
    
  Scenario: Redirected to Maintenance page after login
    Given the administrator user name is "alan" with password "h0m0ph0n3s"
    And I am on the admin login page
    When I log in with "alan" / "h0m0ph0n3s"
    Then I should see "Homophone Administration Page"
    
  Scenario: Different login credentials
    Given the administrator user name is "alan" with password "chicken"
    And I am on the admin login page
    When I log in with "alan" / "chicken"
    Then I should see "Homophone Administration Page"
    
  Scenario: Still on login page if login failed
    Given the administrator user name is "alan" with password "h0m0ph0n3s"
    And I am on the admin login page
    When I log in with "alan" / "badpassword"
    Then I should see "Login Required"

## we want to verify that you can only access the question/quiz creation page if you are admin