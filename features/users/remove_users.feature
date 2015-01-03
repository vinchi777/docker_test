Feature: Remove user

  Background:
    Given I am logged in as admin
    * a review season exists

  Scenario: Remove user from student
    Given a student user exists
    * I am on the users page
    When I remove the user
    Then I should see 1 users
    * the person should not be removed

  Scenario: Remove user from admin
    Given an admin user exists
    * I am on the users page
    When I remove the user
    Then I should see 1 users
    * the person should be removed