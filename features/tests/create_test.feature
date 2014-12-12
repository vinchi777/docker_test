Feature: Create test

  Background:
    Given I am logged in as admin
    * a review season exists
    * I am on the tests page
    When I click the add test link

  Scenario: Fill up required fields
    When I fill up these test information
      | Field              | Value                | Type   |
      | Description        | First long exam      | text   |
      | Date               | Dec. 1, 2014         | text   |
      | Deadline           | Dec. 1, 2014 5:00 pm | text   |
      | Question 0 Text    | What is love?        | text   |
      | Question 0 Choice0 | Love is patient      | text   |
      | Question 0 Choice1 | Love is kind         | text   |
      | Question 0 Choice2 | Love does not envy   | text   |
      | Question 0 Choice3 | Love does not boast  | text   |
      | Question 0 Answer0 |                      | choose |
    * I save the test form
    Then the test should be persisted
    * I should be on the test page

  Scenario: Fill up all fields
    When I fill up these test information
      | Field              | Value                | Type   |
      | Description        | First long exam      | text   |
      | Date               | Dec. 1, 2014         | text   |
      | Deadline           | Dec. 1, 2014 5:00 pm | text   |
      | Timer              | 10                   | text   |
      | Random             |                      | check  |
      | Question 0 Text    | What is love?        | text   |
      | Question 0 Choice0 | Love is patient      | text   |
      | Question 0 Choice1 | Love is kind         | text   |
      | Question 0 Choice2 | Love does not envy   | text   |
      | Question 0 Choice3 | Love does not boast  | text   |
      | Question 0 Ratio   | Love is happiness    | text   |
      | Question 0 Answer2 |                      | choose |
    * I save the test form
    Then the test should be persisted
    * I should be on the test page

  Scenario: Don't fill up question
    When I save the test form
    Then I should see 4 errors