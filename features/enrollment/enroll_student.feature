Feature: Online enrollment for students

  @review_season
  Scenario: Full package enrollment
    Given I am on the enrollment package type page
    When I select "standard_package"
    And I press the "Next" button
    And I fill up these student information
      | firstName | John           | text   |
      | lastName  | dela Cruz      | text   |
      | birthdate | Nov 10, 1992   | text   |
      | sex       | Female         | select |
      | address   | Palo, Leyte,   | text   |
      | contactNo | 123-4567       | text   |
      | email     | john@gmail.com | text   |
    And I press the "Next" button
    And I fill up these student information
      | lastAttended | Cebu Institute of Medicine  | text   |
      | yearGrad     | 2014                        | select |
      | hs           | Bethel International School | text   |
      | hsYear       | 2010                        | select |
      | elem         | Bethel International School | text   |
      | elemYear     | 2000                        | select |
    And I press the "Next" button
    And I press the "Next" button
    And I press the "I Agree" button
    And I press the "Skip" button
    And I press the "Done" button
    Then I should be on the homepage
    And The student should be for confirmation


  Scenario: Missing personal information
    Given I am on the enrollment package type page
    When I select "standard_package"
    And I press the "Next" button
    And I press the "Next" button
    Then I should see 6 errors


  Scenario: Missing educational information
    Given I am on the enrollment package type page
    When I select "standard_package"
    And I press the "Next" button
    And I fill up these student information
      | firstName | John           | text   |
      | lastName  | dela Cruz      | text   |
      | birthdate | Nov 10, 1992   | text   |
      | sex       | Female         | select |
      | address   | Palo, Leyte,   | text   |
      | contactNo | 123-4567       | text   |
      | email     | john@gmail.com | text   |
    When I press the "Next" button
    And I press the "Next" button
    Then I should see 8 errors


  Scenario Outline: Enrollment via pricing page
    Given I am on the pricing page
    When I select the "<Package>" package
    Then I should skip the enrollment package step
    And should be enrolled for the "<Package>" package

  Examples:
    | Package          |
    | Final Coaching   |
    | Standard Package |
    | Double Review    |

  Scenario: Invalid package type in url
    Given I skip the enrollment package step with an invalid package type
    Then I should see an invalid package type error