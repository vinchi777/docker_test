@admin
Feature: Search students

  Scenario Outline: Search students
    And I am on the students page
    When I search for "<Query>"
    Then I should see "<Text>"
    And I should see "<Count>" students

  Examples: Name of the student
    | Query | Text             | Count |
    | Joh   | dela Cruz, John  | 1     |
    | John  | dela Cruz, John  | 1     |
    | hn    | dela Cruz, John  | 1     |
    | de    | dela Cruz, John  | 2     |
    | Maria | dela Cruz, Maria | 1     |
    | Ma    | dela Cruz, Maria | 1     |

  Examples: Address of the student
    | Query | Text             | Count |
    | Tac   | dela Cruz, John  | 2     |
    | City  | dela Cruz, Maria | 2     |

  Examples: School of the student
    | Query    | Text             | Count |
    | Cebu     | dela Cruz, John  | 1     |
    | insti    | dela Cruz, John  | 1     |
    | Medicine | dela Cruz, John  | 2     |
    | St. T    | dela Cruz, Maria | 1     |