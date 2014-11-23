Feature: Add student payment

  @admin
  Scenario: Insert required information
    And I select a student
    When I add a student invoice
    And I fill up these invoice information
      | invoice[package] | Full Package | text   |
      | invoice[season]  | May 2014     | select |
      | invoice[amount]  | 17000        | text   |
    And I submit the invoice form
    Then I should see these invoice information on the student invoice form
      | Full Package |
      | May 2014     |
      | 17,000       |

  Scenario: Insert all fields