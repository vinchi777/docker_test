@admin @student_list
Feature: Remove student
  Scenario: Remove student successfully
    Given I am on the students page
    When I remove a student
    Then I should not see the student

  Scenario: Cancel the removal of student
    Given I am on the students page
    When I cancel the removal of student
    Then I should see the student