Feature: Add students

  Background:
    Given I am logged in as admin

  Scenario: Insert required information
    When I am on the new student page
    * I fill up the following student information
      | first_name    | John                        | text   |
      | last_name     | dela Cruz                   | text   |
      | birthdate     | Nov 10, 1992                | text   |
      | sex           | Female                      | select |
      | address       | Palo, Leyte,                | text   |
      | contact_no    | 123-4567                    | text   |
      | email         | john@gmail.com              | text   |
      | last_attended | Cebu Institute of Medicine  | text   |
      | college_year  | 2014                        | select |
      | hs            | Bethel International School | text   |
      | hs_year       | 2010                        | select |
      | elem          | Bethel International School | text   |
      | elem_year     | 2000                        | select |
    * I save the student form
    Then I should be on the students page

  Scenario: Insert all fields
    When I am on the new student page
    * I fill up the following student information
      | first_name          | John                        | text   |
      | middle_name         | John                        | text   |
      | last_name           | dela Cruz                   | text   |
      | birthdate           | Nov 10, 1992                | text   |
      | sex                 | Female                      | select |
      | address             | Palo, Leyte,                | text   |
      | contact_no          | 123-4567                    | text   |
      | parent_first_name   | Maria                       | text   |
      | parent_last_name    | dela Cruz                   | text   |
      | parent_contact      | 123456789                   | text   |
      | last_attended       | Cebu Institute of Medicine  | text   |
      | recognition         | john@gmail.com              | text   |
      | college_year        | 2014                        | select |
      | hs                  | Bethel International School | text   |
      | hs_year             | 2010                        | select |
      | elem                | Bethel International School | text   |
      | elem_year           | 2000                        | select |
      | referrer_first_name | JK                          | text   |
      | referrer_last_name  | de Veyra                    | text   |
      | referrer_contact    | 123456789                   | text   |
      | why                 | I just like MaxRevOne       | text   |
      | facebook            | juan                        | text   |
      | twitter             | juan                        | text   |
      | linkedin            | juan                        | text   |
    * I save the student form
    Then I should be on the students page

  Scenario: Insert blank data
    When I am on the new student page
    * I save the student form
    Then I should see 11 errors