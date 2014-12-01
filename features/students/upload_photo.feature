@admin
Feature: Upload student photo

  Scenario: Upload photo while creating student
    Given I am on the new student page
    And I fill up these student information
      | firstName    | John                        | text   |
      | lastName     | dela Cruz                   | text   |
      | birthdate    | Nov 10, 1992                | text   |
      | sex          | Female                      | select |
      | address      | Palo, Leyte,                | text   |
      | contactNo    | 123-4567                    | text   |
      | email        | john@gmail.com              | text   |
      | lastAttended | Cebu Institute of Medicine  | text   |
      | yearGrad     | 2014                        | select |
      | hs           | Bethel International School | text   |
      | hsYear       | 2010                        | select |
      | elem         | Bethel International School | text   |
      | elemYear     | 2000                        | select |
    When I attach a photo
    And I submit the student form
    Then I should see the uploaded photo
