Feature: Create test

  Background:
    Given I have logged in as admin
    And A review season exists
    And I am on the tests page
    When I click the add test link

  Scenario: Fill up required fields
    When I fill in the following "test" details
      | description      | First long exam      | text  |
      | date             | Dec. 1, 2014         | text  |
      | deadline         | Dec. 1, 2014 5:00 pm | text  |
      | question_text    | What is love?        | text  |
      | question_choice1 | Love is patient      | text  |
      | question_choice2 | Love is kind         | text  |
      | question_choice3 | Love does not envy   | text  |
      | question_choice4 | Love does not boast  | text  |
      | question_answer2 |                      | check |
    And I submit the test form
    Then the test is persisted
    And I should be on the test page

  Scenario: Fill up all fields
    When I fill in the following "test" details
      | description      | First long exam      | text  |
      | date             | Dec. 1, 2014         | text  |
      | deadline         | Dec. 1, 2014 5:00 pm | text  |
      | timer            | 10                   | text  |
      | random           |                      | check |
      | question_text    | What is love?        | text  |
      | question_choice1 | Love is patient      | text  |
      | question_choice2 | Love is kind         | text  |
      | question_choice3 | Love does not envy   | text  |
      | question_choice4 | Love does not boast  | text  |
      | question_ratio   | Love is hapiness     | text  |
      | question_answer2 |                      | check |
    And I submit the test form
    Then the test is persisted
    And I should be on the test page

  Scenario: Don't fill up question
    When I submit the test form
    Then I should see 4 errors