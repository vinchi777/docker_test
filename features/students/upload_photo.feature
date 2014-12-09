Feature: Upload student photo

  Scenario: Upload photo while creating student
    Given I am logged in as admin
    * I am on the new student page
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
    When I attach a photo
    * I save the student form
    Then I should see the uploaded photo
