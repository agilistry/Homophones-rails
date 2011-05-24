Feature: Registering

  Scenario: Successful registration sends email and shows welcome message
    Given I sign up with:
      | Email            | First name | Last name | Password |
      | patmaddox@me.com | Pat        | Maddox    | supdawg  |
    # Then I should see the "confirmation email sent" message
    And "patmaddox@me.com" should receive an email
    When I open the email
    Then I should see the email delivered from "admin@mrhomophone.com"
    And I should see it is a multi-part email
    When I click the confirmation link in the email
    # Then I should see the "registration confirmed" message
    And I should be logged in as "patmaddox@me.com"
    
  # Scenario: Attempting to log in before confirming shows unconfirmed error message
  #   Given I sign up with:
  #     | Email               | First name | Last name | Password |
  #     | someone@example.com | Some       | One       | password |
  #   When I log in with "someone@example.com" / "password"
  #   Then I should be on the Login page
  #   And I should see "Your account exists, but has not yet been confirmed."
