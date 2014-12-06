Feature: Create test

  Background:
    Given I am logged in as admin
    * a review season exists
    * I am on the tests page
    When I click the add test link

  Scenario: Fill up required fields
    When I fill in the following "test" details
      | Attribute          | Value                | Type   |
      | description        | First long exam      | text   |
      | date               | Dec. 1, 2014         | text   |
      | deadline           | Dec. 1, 2014 5:00 pm | text   |
      | question_0_text    | What is love?        | text   |
      | question_0_choice0 | Love is patient      | text   |
      | question_0_choice1 | Love is kind         | text   |
      | question_0_choice2 | Love does not envy   | text   |
      | question_0_choice3 | Love does not boast  | text   |
      | question_0_answer0 |                      | choose |
    * I save the test form
    Then the test is persisted
    * I should be on the test page

  Scenario: Fill up all fields
    When I fill in the following "test" details
      | Attribute          | Value                | Type   |
      | description        | First long exam      | text   |
      | date               | Dec. 1, 2014         | text   |
      | deadline           | Dec. 1, 2014 5:00 pm | text   |
      | timer              | 10                   | text   |
      | random             |                      | check  |
      | question_0_text    | What is love?        | text   |
      | question_0_choice0 | Love is patient      | text   |
      | question_0_choice1 | Love is kind         | text   |
      | question_0_choice2 | Love does not envy   | text   |
      | question_0_choice3 | Love does not boast  | text   |
      | question_0_ratio   | Love is happiness    | text   |
      | question_0_answer2 |                      | choose |
    * I save the test form
    Then the test is persisted
    * I should be on the test page

  Scenario: Don't fill up question
    When I save the test form
    Then I should see 4 errors