Feature: Remove test

  Scenario: Remove test in test page
    Given I am logged in as admin
    * a test exists
    * I am on the tests page
    When I click on the remove test button
    * I click on "Yes"
    Then I should not see the test
    * the test should not exist

  Scenario: Cancel removal of test in test page
    Given I am logged in as admin
    * a test exists
    * I am on the tests page
    When I click on the remove test button
    * I click on "No"
    Then I should see the test
    * the test should exist