@admin
Feature: Add student payment

  Scenario: Insert required information
    Given I select a student
    And I add a student invoice
    When I fill up these invoice information
      | package | Full Package | text   |
      | season  | May 2014     | select |
      | amount  | 17000        | text   |
    And I submit the invoice form
    Then I should see these invoice information on the student invoice form
      | Full Package |
      | May 2014     |
      | 17,000       |

  Scenario: Insert all information
    Given I select a student
    And I add a student invoice
    When I fill up these invoice information
      | package     | Full Package | text   |
      | season      | May 2014     | select |
      | description | 50% Discount | text   |
      | amount      | 17000        | text   |
      | discount    | 0.5          | text   |
    And I submit the invoice form
    Then I should see these invoice information on the student invoice form
      | Full Package |
      | 50% Discount |
      | May 2014     |
      | 8,500        |