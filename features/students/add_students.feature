@admin @student_list
Feature: Add students

  Scenario: Insert required information
    When I am on the new student page
    And I fill up these student information
      | student[firstName]    | John                        | text   |
      | student[lastName]     | dela Cruz                   | text   |
      | student[birthdate]    | Nov 10, 1992                | text   |
      | student[sex]          | Female                      | select |
      | student[address]      | Palo, Leyte,                | text   |
      | student[contactNo]    | 123-4567                    | text   |
      | student[email]        | john@gmail.com              | text   |
      | student[lastAttended] | Cebu Institute of Medicine  | text   |
      | student[yearGrad]     | 2014                        | select |
      | student[hs]           | Bethel International School | text   |
      | student[hsYear]       | 2010                        | select |
      | student[elem]         | Bethel International School | text   |
      | student[elemYear]     | 2000                        | select |
    And I submit the student form
    Then I should be on the students page

  Scenario: Insert all fields
    When I am on the new student page
    And I fill up these student information
      | student[firstName]         | John                        | text   |
      | student[middleName]        | John                        | text   |
      | student[lastName]          | dela Cruz                   | text   |
      | student[birthdate]         | Nov 10, 1992                | text   |
      | student[sex]               | Female                      | select |
      | student[address]           | Palo, Leyte,                | text   |
      | student[contactNo]         | 123-4567                    | text   |
      | student[parentFirstName]   | Maria                       | text   |
      | student[parentContact]     | delaCruz                    | text   |
      | student[lastAttended]      | Cebu Institute of Medicine  | text   |
      | student[recognition]       | john@gmail.com              | text   |
      | student[yearGrad]          | 2014                        | select |
      | student[hs]                | Bethel International School | text   |
      | student[hsYear]            | 2010                        | select |
      | student[elem]              | Bethel International School | text   |
      | student[elemYear]          | 2000                        | select |
      | student[referrerFirstName] | JK                          | text   |
      | student[referrerLastName]  | de Veyra                    | text   |
      | student[why]               | I just like MaxRevOne       | text   |
      | student[facebook]          | juan                        | text   |
      | student[twitter]           | juan                        | text   |
      | student[linkedin]          | juan                        | text   |
    And I submit the student form
    Then I should be on the students page

  Scenario: Insert blank data
    When I am on the new student page
    And I submit the student form
    Then I should see 11 errors