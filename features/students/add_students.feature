Feature: Add students

  Background:
    Given I am logged in as admin

  Scenario: Insert required information
    When I am on the new student page
    * I fill up these student information
      | Field         | Value                       | Type   |
      | First Name    | John                        | text   |
      | Last Name     | dela Cruz                   | text   |
      | Birthdate     | Nov 10, 1992                | text   |
      | Sex           | Female                      | select |
      | Address       | Palo, Leyte,                | text   |
      | Contact No    | 123-4567                    | text   |
      | Email         | john@gmail.com              | text   |
      | Last Attended | Cebu Institute of Medicine  | text   |
      | College Year  | 2014                        | select |
      | HS            | Bethel International School | text   |
      | HS Year       | 2010                        | select |
      | Elem          | Bethel International School | text   |
      | Elem Year     | 2000                        | select |
    * I save the student form
    Then I should be on the students page

  Scenario: Insert all fields
    When I am on the new student page
    * I fill up these student information
      | Field               | Value                       | Type   |
      | First Name          | John                        | text   |
      | Middle Name         | John                        | text   |
      | Last Name           | dela Cruz                   | text   |
      | Birthdate           | Nov 10, 1992                | text   |
      | Sex                 | Female                      | select |
      | Address             | Palo, Leyte,                | text   |
      | Contact No          | 123-4567                    | text   |
      | Parent First Name   | Maria                       | text   |
      | Parent Last Name    | dela Cruz                   | text   |
      | Parent Contact      | 123456789                   | text   |
      | Last Attended       | Cebu Institute of Medicine  | text   |
      | Recognition         | john@gmail.com              | text   |
      | College Year        | 2014                        | select |
      | HS                  | Bethel International School | text   |
      | HS Year             | 2010                        | select |
      | Elem                | Bethel International School | text   |
      | Elem Year           | 2000                        | select |
      | Referrer First Name | JK                          | text   |
      | Referrer Last Name  | de Veyra                    | text   |
      | Referrer Contact    | 123456789                   | text   |
      | Why                 | I just like MaxRevOne       | text   |
      | Facebook            | juan                        | text   |
      | Twitter             | juan                        | text   |
      | Linkedin            | juan                        | text   |
    * I save the student form
    Then I should be on the students page

  Scenario: Insert blank data
    When I am on the new student page
    * I save the student form
    Then I should see 11 errors