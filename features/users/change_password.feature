Feature: Change user password

  Scenario: Change user password by an admin
    Given I am logged in as admin
    * users exists
    * I am on the users page
    When I click on "Change Password"
    * I fill up these user information
      | Field            | Value       | Type |
      | Password         | password123 | text |
      | Confirm Password | password123 | text |
    * I press the "Update Password" button
    Then the user password should be updated

  Scenario: Password and confirm password do not match
    Given I am logged in as admin
    * users exists
    * I am on the users page
    When I click on "Change Password"
    * I fill up these user information
      | Field            | Value         | Type |
      | Password         | password123   | text |
      | Confirm Password | password12345 | text |
    * I press the "Update Password" button
    Then I should see 1 errors

  Scenario: Change your own password
    Given a review season exists
    * I am logged in as a student
    * I am on the change password page
    When I fill up these user information
      | Field            | Value       | Type |
      | Current Password | 123456789   | text |
      | Password         | password123 | text |
      | Confirm Password | password123 | text |
    * I press the "Update Password" button
    Then the user password should be updated