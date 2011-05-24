Feature: Administrator can create new quiz questions
  Background:
    Given I am logged in

  Scenario: Create a new quiz question with one answer
    When I go to the new quiz question page
    And I fill in "Ask" with "What is the largest set of homophones?"
    And I fill in "Responses" with "air, e'er, err"
    And I fill in "Response size" with "1"
    And I press "Save"
    Then I should see "Quiz question saved!"
    And I should be on the quiz question page
  
  Scenario: Fail to save a new quiz question
    When I go to the new quiz question page
    And I fill in "Ask" with "What is the largest set of homophones?"
    And I fill in "Responses" with "air, e'er, err"
    And I fill in "Response size" with ""
    And I press "Save"
    Then I should see "Response size can't be blank"
    And I should be on the create quiz question page
  
  Scenario: View a list of quiz questions
    Given I have the quiz question:
      | ask | responses | response_size |
      | What is the largest homonym set? | ere, air, e'er | 1 |
    When I go to the quiz question page
    Then I should see "What is the largest homonym set?"
    And I should see "ere, air, e'er" 
    And I should see "1"

  @wip
  Scenario: Edit a quiz question
    Given I have the quiz question:
      | ask | responses | response_size |
      | What is the largest homonym set? | ere, air, e'er | 1 |
    When I go to the quiz question page
    And I follow "Edit" 
    And I fill in "Ask" with "What is the second largest set of homophones?"
    And I press "Save"
    Then I should see "What is the second largest set of homophones?"
    And I should be on the quiz question page

  Scenario: Delete a quiz question
    Given I have the quiz question:
      | ask | responses | response_size |
      | What is the largest homonym set? | ere, air, e'er | 1 |
    When I go to the quiz question page
    And I press "Delete"
    Then I should not see "What is the largest homonym set?"
    And I should see "Quiz question deleted!"
    And I should be on the quiz question page   
