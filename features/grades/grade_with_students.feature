@admin
Feature: Grades with students

  Background:
    Given A review season exists

  Scenario: Add grades for enrolled students
    Given Students exists
    And I am on the new grade page
    Then I should see 2 students
    When I fill in the following "grade" details
      | Field       | Value       | Type |
      | description | Semi Finals | text |
      | date        | 05-10-2014  | text |
      | points      | 200         | text |
    And I fill up the following student grades
      | Value |
      | 50    |
      | 80    |
    And I submit the grade form
    Then I should successfully add the "Semi Finals" grade
    And I should see a grade with an average of 33

  Scenario: Wrong average calculation
    Given Students exists
    And I am on the new grade page
    When I fill in the following "grade" details
      | Field       | Value       | Type |
      | description | Semi Finals | text |
      | date        | 05-10-2014  | text |
      | points      | 200         | text |
    And I fill up the following student grades
      | Value |
      | 50    |
      | 80    |
    And I submit the grade form
    Then I should not see a grade with an average of 32

  Scenario: Searching students
    Given Students exists
    And I am on the new grade page
    Then I should be able to search for the following student queries
      | Keyword   | Result |
      | bc        | 1      |
      | ef        | 1      |
      | dela Cruz | 2      |