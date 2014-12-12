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

  Scenario: Automatically confirm students upon payment of reservation fee
    When student pay at least the reservation fee
    Then the student is confirmed