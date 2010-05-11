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
    When I fill in "User Name" with "alan"
    And I fill in "Password" with "h0m0ph0n3s"
    And I press "Login"
    Then I should see "Homophone Administration Page"
    
  Scenario: Still on login page if login failed
    Given the administrator user name is "alan" with password "h0m0ph0n3s"
    And I am on the admin login page
    When I fill in "User Name" with "alan"
    And I fill in "Password" with "haxordude"
    And I press "Login"
    Then I should see "Login Required"