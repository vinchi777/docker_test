Feature: Show grades per student
  Background:
    Given I am logged in as admin
    * a review season exists
    * students exist

  Scenario: No grades for student
    Given I am on an existing student's grade page
    Then I should not see any grades

  Scenario: Existing grade for student
    Given a grade with students exists
    Given I am on an existing student's grade page
    Then I should see "NLE Examination"