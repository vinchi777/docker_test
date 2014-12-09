Feature: Basic grade

  Background:
    Given I am logged in as admin
    * a review season exists

  Scenario: Add new grade
    Given I am on the grades page
    * I click the add grade link
    Then I should be redirected to the new grade page
    When I fill up these grade information
      | Field       | Value             | Type |
      | description | Mock Exam for NLE | text |
      | date        | 05-10-2014        | text |
      | points      | 100               | text |
    * I submit the grade form
    Then I should successfully add the "Mock Exam for NLE" grade
    * I should be redirected to the grades page
    * I should see "Mock Exam for NLE"

  Scenario: Editing a grade
    Given a grade exists
    And I am on the grades page
    When I click the first existing grade
    And I fill up these grade information
      | Field       | Value        | Type |
      | description | Super Finals | text |
    * I submit the grade form
    Then I should see "Super Finals"

  Scenario: Deleting a grade
    Given I am on an existing grade page
    When I press the delete button for grade
    Then the grade should be deleted

  Scenario: Missing grade information
    Given I am on the grades page
    * I click the add grade link
    * I submit the grade form
    Then I should see 3 errors

  Scenario: Visit new grades path through url
    Given I am on the new grade page
    Then I should see "Since no season is specified, the current review season will be used."

  Scenario: Add grade without review season
    Given No review season exists
    * I am on the new grade page
    Then I should see "No season available. Please add review season first."