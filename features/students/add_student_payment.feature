@admin
Feature: Add student payment

  Scenario: Insert required information
    Given I select a student
    And I add a student invoice
    When I fill up these invoice information
      | invoice[package] | Full Package | text   |
      | invoice[season]  | May 2014     | select |
      | invoice[amount]  | 17000        | text   |
    And I submit the invoice form
    Then I should see these invoice information on the student invoice form
      | Full Package |
      | May 2014     |
      | 17,000       |

  Scenario: Insert all information
    Given I select a student
    And I add a student invoice
    When I fill up these invoice information
      | invoice[package]     | Full Package | text   |
      | invoice[season]      | May 2014     | select |
      | invoice[description] | 50% Discount | text   |
      | invoice[amount]      | 17000        | text   |
      | invoice[discount]    | 0.5          | text   |
    And I submit the invoice form
    Then I should see these invoice information on the student invoice form
      | Full Package |
      | 50% Discount |
      | May 2014     |
      | 8,500        |