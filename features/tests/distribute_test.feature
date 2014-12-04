Feature: Distribute test

  Background:
    Given I have logged in as admin
    And A review season exists
    And enrolled students exists for the current season
    And a test exists
    When I click on the test
    When I click the Publish button

  Scenario: Student exists on the modal
    Then I should see all students selected

  Scenario: Publish to all students
    When I click the Start button
    Then I should not see the student select modal
    And the students have answer sheets

  Scenario: Filter students
    When I search for "Aquino"
    Then I should see 1 student for selection
    When I click the Start button
    Then "Aquino" should have answer sheet
    And other students should not have answer sheets

