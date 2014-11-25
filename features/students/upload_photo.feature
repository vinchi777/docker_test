@admin
Feature: Upload student photo

  Scenario: Upload photo while creating student
    Given I am on the new student page
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
    When I attach a photo
    And I submit the student form
    Then I should see the uploaded photo
