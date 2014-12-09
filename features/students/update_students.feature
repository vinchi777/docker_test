Feature: Update students

  Background:
    Given I am logged in as admin
    * students exist
    * I am on the student page

  Scenario: Update fields
    When I fill up these student information
      | Field      | Value        | Type |
      | First Name | Erik         | text |
      | Last Name  | dela Torre   | text |
      | Birthdate  | Nov 10, 1990 | text |
      | Address    | Palo, Leyte  | text |
    * I save the student form
    Then I should be on the students page
    * the student should be updated