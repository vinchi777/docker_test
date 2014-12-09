Feature: Online enrollment for students

  Scenario: Full package enrollment
    Given a review season exists
    * I am on the enrollment package type page
    When I select "standard_package"
    * I press the "Next" button
    * I fill up the following student information
      | first_name | John           | text   |
      | last_name  | dela Cruz      | text   |
      | birthdate  | Nov 10, 1992   | text   |
      | sex        | Female         | select |
      | address    | Palo, Leyte,   | text   |
      | contact_no | 123-4567       | text   |
      | email      | john@gmail.com | text   |
    * I press the "Next" button
    * I fill up the following student information
      | last_attended | Cebu Institute of Medicine  | text   |
      | college_year  | 2014                        | select |
      | hs            | Bethel International School | text   |
      | hs_year       | 2010                        | select |
      | elem          | Bethel International School | text   |
      | elem_year     | 2000                        | select |
    * I press the "Next" button
    * I press the "Next" button
    * I press the "I Agree" button
    * I press the "Skip" button
    * I press the "Done" button
    Then I should be on the homepage
    * The student should be for confirmation

  Scenario: Missing personal information
    Given I am on the enrollment package type page
    When I select "standard_package"
    * I press the "Next" button
    * I press the "Next" button
    Then I should see 6 errors


  Scenario: Missing educational information
    Given I am on the enrollment package type page
    When I select "standard_package"
    * I press the "Next" button
    * I fill up the following student information
      | first_name | John           | text   |
      | last_name  | dela Cruz      | text   |
      | birthdate  | Nov 10, 1992   | text   |
      | sex        | Female         | select |
      | address    | Palo, Leyte,   | text   |
      | contact_no | 123-4567       | text   |
      | email      | john@gmail.com | text   |
    When I press the "Next" button
    * I press the "Next" button
    Then I should see 5 errors


  Scenario Outline: Enrollment via pricing page
    Given I am on the pricing page
    When I select the "<Package>" package
    Then I should skip the enrollment package step
    * should be enrolled for the "<Package>" package

  Examples:
    | Package          |
    | Final Coaching   |
    | Standard Package |
    | Double Review    |

  Scenario: Invalid package type in url
    Given I skip the enrollment package step with an invalid package type
    Then I should see an invalid package type error