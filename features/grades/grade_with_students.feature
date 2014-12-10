Feature: Grades with students

  Background:
    Given I am logged in as admin
    * a review season exists
    * students exist
    * I am on the new grade page

  Scenario: Add grades for enrolled students
    Then I should see 2 students
    When I fill up these grade information
      | Field       | Value       | Type |
      | description | Semi Finals | text |
      | date        | 05-10-2014  | text |
      | points      | 200         | text |
    * I fill up the following student grades
      | Value |
      | 50    |
      | 80    |
    * I submit the grade form
    Then I should successfully add the "Semi Finals" grade
    * I should see a grade with an average of 33

  Scenario: Wrong average calculation
    When I fill up these grade information
      | Field       | Value       | Type |
      | description | Semi Finals | text |
      | date        | 05-10-2014  | text |
      | points      | 200         | text |
    * I fill up the following student grades
      | Value |
      | 50    |
      | 80    |
    * I submit the grade form
    Then I should not see a grade with an average of 32

  Scenario: Searching students
    * I should be able to search for the following student queries
      | Keyword   | Result |
      | bc        | 1      |
      | ef        | 1      |
      | dela Cruz | 2      |

  Scenario: Using the select/deselect in select student modal
    When I click the edit students icon
    Then I should see the select students modal
    When I click the deselect all icon
    Then all students should be deselected
    When I click the select all icon
    Then all students should be selected
    When I deselect "dela Cruz, abc" at the student select modal
    Then I should not see the select indicator on "dela Cruz, abc"

  Scenario: Searching students in select student modal
    When I click the edit students icon
    Then I should search for the following students in the select modal
      | Keyword   | Result |
      | abc       | 1      |
      | def       | 1      |
      | dela Cruz | 2      |
      | abf       | 0      |

  Scenario: Removing all students from list
    When I click the edit students icon
    * I click the deselect all icon
    * I press the "Confirm" button
    Then I should see 0 students

  Scenario: Exclude student from grading
    When I click the edit students icon
    * I deselect "dela Cruz, def" at the student select modal
    * I press the "Confirm" button
    Then I should not see "dela Cruz, def"
    When I fill up these grade information
      | Field       | Value       | Type |
      | description | Semi Finals | text |
      | date        | 05-10-2014  | text |
      | points      | 200         | text |
    * I fill up the following student grades
      | Value |
      | 50    |
    * I submit the grade form
    Then I should successfully add the "Semi Finals" grade
    And the grade should only contain 1 student grade

  Scenario: Removing a student from existing grade
    Given I am on an existing grade with students page
    * I click the edit students icon
    * I deselect "dela Cruz, def" at the student select modal
    * I press the "Confirm" button
    * I submit the grade form
    Then the grade should only contain 1 student grade

  Scenario: Adding a new student in existing grade
    Given I am on an existing grade with a student page
    * I click the edit students icon
    * I select "dela Cruz, def" at the student select modal
    * I press the "Confirm" button
    * I fill up the following student grades
      | Value |
      | 50    |
      | 49    |
    * I submit the grade form
    Then the grade should only contain 2 student grades



