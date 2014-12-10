Feature: Upload student photo

  Scenario: Upload photo while creating student
    Given I am logged in as admin
    * I am on the new student page
    * I fill up these student information
      | Field         | Value                       | Type   |
      | First Name    | John                        | text   |
      | Last Name     | dela Cruz                   | text   |
      | Birthdate     | Nov 10, 1992                | text   |
      | Sex           | Female                      | select |
      | Civil Status  | Married                     | select |
      | Address       | Palo, Leyte,                | text   |
      | Contact No    | 123-4567                    | text   |
      | Email         | john@gmail.com              | text   |
      | Last Attended | Cebu Institute of Medicine  | text   |
      | College Year  | 2014                        | select |
      | HS            | Bethel International School | text   |
      | HS Year       | 2010                        | select |
      | Elem          | Bethel International School | text   |
      | Elem Year     | 2000                        | select |
    When I attach a photo
    * I save the student form
    Then I should see the uploaded photo
