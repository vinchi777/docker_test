Feature: Online enrollment for students

  @review_season
  Scenario: Full package enrollment
    Given I am on the enrollment package type page
    When I select "standard_package"
    And I press the "Next" button
    And I fill up these student information
      | student[firstName] | John           | text   |
      | student[lastName]  | dela Cruz      | text   |
      | student[birthdate] | Nov 10, 1992   | text   |
      | student[sex]       | Female         | select |
      | student[address]   | Palo, Leyte,   | text   |
      | student[contactNo] | 123-4567       | text   |
      | student[email]     | john@gmail.com | text   |
    And I press the "Next" button
    And I fill up these student information
      | student[lastAttended] | Cebu Institute of Medicine  | text |
      | student[yearGrad]     | 2014                        | text |
      | student[hs]           | Bethel International School | text |
      | student[hsYear]       | 2010                        | text |
      | student[elem]         | Bethel International School | text |
      | student[elemYear]     | 2000                        | text |
    And I press the "Next" button
    And I press the "Next" button
    And I press the "I Agree" button
    And I press the "Skip" button
    And I press the "Done" button
    Then I should be on the homepage
    And The student should be for confirmation