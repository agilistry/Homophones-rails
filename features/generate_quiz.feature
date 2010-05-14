Feature: Nancy can generate a quiz on homophones for her class
  Scenario: Generating a basic quiz
    Given I have the quiz question:
      | ask | responses | response_size |
      | What is the largest homophone set? | ere, air, e'er | 1 |
    When I go to the generate quiz page
    Then I see the quiz questions:
      | question_text |
      | What is the largest homophone set? |