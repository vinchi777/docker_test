@admin
Feature: Add grades by batch

  Background:
    Given A review season exists

  Scenario: Add new grade
    Given I am on the grades page
    And I click the add grade link
    Then I should be redirected to the new grade page
    When I fill in the following "grade" details
      | Field       | Value             | Type |
      | description | Mock Exam for NLE | text |
      | date        | 05-10-2014        | text |
      | points      | 100               | text |
    And I submit the grade form
    Then I should successfully add the "Mock Exam for NLE" grade
    And I should be redirected to the grades page
    And I should see "Mock Exam for NLE"
    And I should see "100"

  Scenario: Missing grade information
    Given I am on the new grade page
    And I submit the grade form
    Then I should see 3 errors

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

