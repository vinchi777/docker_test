Feature: Search students

  Scenario: Search students
    Given I am logged in as admin
    * students exist for searching
    * I am on the students page
    Then I should be able to search students by name
      | Query | Text             | Count |
      | Joh   | dela Cruz, John  | 1     |
      | John  | dela Cruz, John  | 1     |
      | hn    | dela Cruz, John  | 1     |
      | de    | dela Cruz, John  | 2     |
      | Maria | dela Cruz, Maria | 1     |
      | Ma    | dela Cruz, Maria | 1     |
    * I should be able to search students by address
      | Query | Text             | Count |
      | Tac   | dela Cruz, John  | 2     |
      | City  | dela Cruz, Maria | 2     |
    * I should be able to search students by school
      | Query    | Text             | Count |
      | Cebu     | dela Cruz, John  | 1     |
      | insti    | dela Cruz, John  | 1     |
      | Medicine | dela Cruz, John  | 2     |
      | St. T    | dela Cruz, Maria | 1     |