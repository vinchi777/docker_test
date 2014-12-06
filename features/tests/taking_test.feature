Feature: Taking tests

  Background:
    Given I am logged in as a student
    And A review season exists
    And I am enrolled for the current season

  Scenario: Answer sheet exists
    Given a test with timer exists and published
    When I am on the student grade page
    Then I should see this answer sheet
      | Attribute   | Value           | Type    |
      | item        | 1               | text    |
      | timer       | true            | boolean |
      | date        | Dec 4, 2014     | text    |
      | description | First long exam | text    |
    And I can take on the answer sheet
    And I should see the timer

  Scenario: Answer sheet with no timer exists
    Given a test without timer exists and published
    Then I should see this answer sheet
      | Attribute   | Value           | Type    |
      | item        | 1               | text    |
      | timer       | false           | boolean |
      | date        | Dec 4, 2014     | text    |
      | description | First long exam | text    |
    And I can take on the answer sheet
    And I should not see the timer

  Scenario: Take the test
    Given a test exists
    When I am on the answer sheet
    And I fill up the answer sheet
      | Question | Answer |
      | 1        | 2      |
    And I submit the answer sheet
    Then I should not be able to fill up the answer sheet
    And I should not be able to submit the answer sheet
    And I should see my answers
    And I should see message to wait for results after deadline

  Scenario: Take the test and reach the timer
    Given a test exists
    When I am on the answer sheet
    And I wait for the timer to end
    Then I should not be able to fill up the answer sheet
    And I should not be able to submit the answer sheet
    And I should see message to wait for results after deadline

  Scenario: See result after deadline
    Given a test exists
    And I take the test
    And wait until the deadline
    Then I should see my score of the test
    And I should see the correct answers
    And I should see the rationalizations

  Scenario: Past the deadline
    Given a test exists and past the deadline
    When I try to take the test
    Then I should not be able to fill up the answer sheet
    And I should not be able to submit the answer sheet
    And I should see my score of the test
    And I should see the correct answers
    And I should see the rationalizations