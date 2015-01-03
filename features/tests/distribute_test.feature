Feature: Distribute test

  Background:
    Given I am logged in as admin
    * a review season exists
    * enrolled students exists for the current season
    * a test exists
    * I am on the tests page
    When I click on the test
    * I press the "Publish" button

  Scenario: Student exists on the modal
    Then I should see all students selected

  Scenario: Publish to all students
    When I press the "Start" button
    Then I should not see the student select modal
    * the students have answer sheets

  Scenario: Filter students
    When I deselect all students
    * I search for "Bob" in student select
    * select the student
    * I press the "Start" button
    Then "Bob" should have answer sheet
    * other students should not have answer sheets

  Scenario: Redistribute to remaining students
    When I select for "Bob" in student select
    * I press the "Start" button
    * I press the "Publish" button
    Then I should not see "Bob"
    * I should see other students in student select
