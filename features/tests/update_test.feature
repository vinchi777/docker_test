Feature: Update test

  Background:
    Given I am logged in as admin
    * a review season exists
    * a test exists
    * I am on the test page

  Scenario: Fill up required fields
    When I fill up these test information
      | Field              | Value                | Type   |
      | Description        | Second long exam     | text   |
      | Date               | Nov. 1, 2014         | text   |
      | Deadline           | Nov. 1, 2014 5:00 pm | text   |
      | Question 0 Text    | What is love?        | text   |
      | Question 0 Choice0 | Love is patient      | text   |
      | Question 0 Answer2 |                      | choose |
    * I press the "Update" button
    Then the test should be updated