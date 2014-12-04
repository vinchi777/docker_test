Feature: Taking tests

  Background:
    Given I have logged in as a student
    And A review season exists
    And I am enrolled for the current season

  Scenario: Answer sheet exists
    Given a test with timer exists and published
    When I am on the student grade page
    Then I should see this answer sheet
      | item        | 1               | text    |
      | timer       | true            | boolean |
      | date        | Dec 4, 2014     | text    |
      | description | First long exam | text    |
    And I can take on the answer sheet
    And I should see the timer

  Scenario: Answer sheet with no timer exists
    Given a test without timer exists and published
    Then I should see this answer sheet
      | item        | 1               | text    |
      | timer       | false           | boolean |
      | date        | Dec 4, 2014     | text    |
      | description | First long exam | text    |
    And I can take on the answer sheet
    And I should not see the timer