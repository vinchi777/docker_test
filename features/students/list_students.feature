Feature: List students

  Background:
    Given I am logged in as admin
    * a review season exists
    * students exist with balance
    * I am on the students page

  Scenario: Shows information
    Then I should see names, email, last school, address and balance of the students