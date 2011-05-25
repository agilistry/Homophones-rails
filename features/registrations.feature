Feature: Registering

  Scenario: Successful registration sends email and shows welcome message
    Given I sign up with:
      | Email            | First name | Last name | Password |
      | patmaddox@me.com | Pat        | Maddox    | supdawg  |
    And "patmaddox@me.com" should receive an email
    When I open the email
    Then I should see the email delivered from "admin@mrhomophone.com"
    And I should see it is a multi-part email
    When I click the confirmation link in the email
    And I should be logged in as "patmaddox@me.com"

  Scenario: Signing up shows sent email notice, and does not show unconfirmed message
    When I sign up with:
      | Email            | First name | Last name | Password |
      | patmaddox@me.com | Pat        | Maddox    | supdawg  |
    Then I should see "You have signed up successfully. A confirmation was sent to your e-mail."
    Then I should not see "we could not sign you in because your account is unconfirmed"
    Then I should not see "Your account exists, but has not yet been confirmed"
    
  Scenario: Attempting to log in before confirming shows unconfirmed error message
    Given I sign up with:
      | Email               | First name | Last name | Password |
      | someone@example.com | Some       | One       | password |
    When I log in with "someone@example.com" / "password"
    Then I should be on the Login page
    And I should see "Your account exists, but has not yet been confirmed."
  
  Scenario: Entered data persists when problem creating account
    When I sign up with:
      | Email            | First name | Last name | Password |
      | patmaddox@me.com | Pat        | Maddox    | a        |
    Then I should see "prohibited this user from being saved"
    And the "First name" field should contain "Pat"
    And the "Last name" field should contain "Maddox"
    And the "Email" field should contain "patmaddox@me.com"
    
    
