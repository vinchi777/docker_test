Feature: Filtering students

  Background:
    Given I am logged in as admin
    * a review season exists
    * students exist for filtering

  Scenario Outline: Filter by review season and enrollment status
    Given I am on the students page
    When I choose "<Season>" season and "<Type>" type
    Then I should see "<Count>" students

  Examples:
    | Season   | Type      | Count |
    | All      | All       | 4     |
    | All      | Enrolling | 1     |
    | All      | Enrolled  | 2     |
    | May 2014 | All       | 3     |
    | May 2014 | Enrolling | 1     |
    | May 2014 | Enrolled  | 2     |
