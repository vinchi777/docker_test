Feature: Remove student

  Background:
    Given I am logged in as admin
    * students exist
    * I am on the students page

  Scenario: Remove student successfully
    When I remove a student
    Then I should not see the student

  Scenario: Cancel the removal of student
    When I cancel the removal of student
    Then I should see the student