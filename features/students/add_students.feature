Feature: Add students

  Background:
    Given I am logged in as admin

  Scenario: Insert required information
    When I am on the new student page
    * I fill up the following student information
      | first_name   | John                        | text   |
      | last_name    | dela Cruz                   | text   |
      | birthdate    | Nov 10, 1992                | text   |
      | sex          | Female                      | select |
      | address      | Palo, Leyte,                | text   |
      | contact_no   | 123-4567                    | text   |
      | email        | john@gmail.com              | text   |
      | lastAttended | Cebu Institute of Medicine  | text   |
      | yearGrad     | 2014                        | select |
      | hs           | Bethel International School | text   |
      | hsYear       | 2010                        | select |
      | elem         | Bethel International School | text   |
      | elemYear     | 2000                        | select |
    * I save the student form
    Then I should be on the students page

  Scenario: Insert all fields
    When I am on the new student page
    * I fill up the following student information
      | first_name        | John                        | text   |
      | middle_name       | John                        | text   |
      | last_name         | dela Cruz                   | text   |
      | birthdate         | Nov 10, 1992                | text   |
      | sex               | Female                      | select |
      | address           | Palo, Leyte,                | text   |
      | contact_no        | 123-4567                    | text   |
      | parentFirstName   | Maria                       | text   |
      | parentContact     | delaCruz                    | text   |
      | lastAttended      | Cebu Institute of Medicine  | text   |
      | recognition       | john@gmail.com              | text   |
      | yearGrad          | 2014                        | select |
      | hs                | Bethel International School | text   |
      | hsYear            | 2010                        | select |
      | elem              | Bethel International School | text   |
      | elemYear          | 2000                        | select |
      | referrerFirstName | JK                          | text   |
      | referrerLastName  | de Veyra                    | text   |
      | why               | I just like MaxRevOne       | text   |
      | facebook          | juan                        | text   |
      | twitter           | juan                        | text   |
      | linkedin          | juan                        | text   |
    * I save the student form
    Then I should be on the students page

  Scenario: Insert blank data
    When I am on the new student page
    * I save the student form
    Then I should see 11 errors