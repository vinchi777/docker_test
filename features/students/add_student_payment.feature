Feature: Add student payment

  @admin
  Scenario: Insert required information
    Given I login successfully as an admin
    And I select a student
    When I add a student invoice
    And I fill up these invoice information
    And I submit the invoice form
    Then I should see the invoice on the student payment form

  Scenario: Insert all fields