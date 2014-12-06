Feature: Taking tests

  Background:
    Given I am logged in as a student
    * A review season exists
    * I am enrolled for the current season

  Scenario: Answer sheet exists
    Given a test with timer exists and published
    When I am on the student grade page
    Then I should see this answer sheet
      | Attribute   | Value           | Type    |
      | item        | 1               | text    |
      | timer       | true            | boolean |
      | date        | Dec 4, 2014     | text    |
      | description | First long exam | text    |
    * I can take on the answer sheet
    * I should see the timer

  Scenario: Answer sheet with no timer exists
    Given a test without timer exists and published
    Then I should see this answer sheet
      | Attribute   | Value           | Type    |
      | item        | 1               | text    |
      | timer       | false           | boolean |
      | date        | Dec 4, 2014     | text    |
      | description | First long exam | text    |
    * I can take on the answer sheet
    * I should not see the timer

  Scenario: Take the test
    Given a test exists
    When I am on the answer sheet
    * I fill up the answer sheet
      | Question | Answer |
      | 1        | 2      |
    * I submit the answer sheet
    Then I should not be able to fill up the answer sheet
    * I should not be able to submit the answer sheet
    * I should see my answers
    * I should see message to wait for results after deadline

  Scenario: Take the test and reach the timer
    Given a test exists
    When I am on the answer sheet
    * I wait for the timer to end
    Then I should not be able to fill up the answer sheet
    * I should not be able to submit the answer sheet
    * I should see message to wait for results after deadline

  Scenario: See result after deadline
    Given a test exists
    * I take the test
    * wait until the deadline
    Then I should see my score of the test
    * I should see the correct answers
    * I should see the rationalizations

  Scenario: Past the deadline
    Given a test exists and past the deadline
    When I try to take the test
    Then I should not be able to fill up the answer sheet
    * I should not be able to submit the answer sheet
    * I should see my score of the test
    * I should see the correct answers
    * I should see the rationalizations