Feature: List test

  Background:
    Given I am logged in as admin
    * a test exists

  Scenario: List tests
    Given I am on the tests page
    Then I should see the test