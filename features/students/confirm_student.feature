Feature: Confirm students

  Background:
    Given I am logged in as admin
    * a review season exists
    * an enrolling student exists

  Scenario: Confirm student on the students page
    Given I am on the students page
    When I press the "Confirm" button
    Then I should see the student is enrolled
    * the student is confirmed

  Scenario: Confirm student on the student page
    Given I am on the student page
    When I press the "Confirm" button
    Then I should see the student is enrolled
    * the student is confirmed