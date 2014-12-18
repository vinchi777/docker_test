Feature: Create users

  Background:
    Given I am logged in as admin

  Scenario: Successfully create user
    Given I am on the users page
    * I click on "Add User"
    When I fill up these user information
      | Field            | Value               | Type |
      | First Name       | John                | text |
      | Middle Name      | Fernandez           | text |
      | Last Name        | dela Cruz           | text |
      | Email            | jdelacruz@yahoo.com | text |
      | Password         | 123456789           | text |
      | Confirm Password | 123456789           | text |
    * I press the "Create User" button
    Then I should not see any modal
    * I should see 2 users
    * email should be sent to "jdelacruz@yahoo.com"
    * I should see unconfirmed student

  Scenario: Error when no fields
    Given I am on the users page
    * I click on "Add User"
    When I press the "Create User" button
    Then I should see 6 errors
    * email should not be sent to "jdelacruz@yahoo.com"

  Scenario: Create user from student
    Given students exist
    * I am on the students page
    When I click the user icon
    * I press the "Yes" button
    Then I should not see any modal
    * a user should be created