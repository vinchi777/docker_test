Feature: Distribute test

  Background:
    Given I have logged in as admin
    * A review season exists
    * enrolled students exists for the current season
    * a test exists
    When I click on the test
    * I press the "Publish" button

  Scenario: Student exists on the modal
    Then I should see all students selected

  Scenario: Publish to all students
    When I press the "Start" button
    Then I should not see the student select modal
    * the students have answer sheets

  Scenario: Filter students
    When I search for "Aquino"
    Then I should see 1 student for selection
    When I press the "Start" button
    Then "Aquino" should have answer sheet
    * other students should not have answer sheets

