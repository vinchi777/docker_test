Feature: Add student payment

  Background:
    Given I am logged in as admin
    * students exist

  Scenario: Insert required information
    Given I add a student invoice
    When I fill up these invoice information
      | Field   | Value        | Type   |
      | Package | Full Package | text   |
      | Season  | May 2014     | select |
      | Amount  | 17000        | text   |
    * I submit the invoice form
    Then I should see these invoice information on the student invoice form
      | Full Package |
      | May 2014     |
      | 17,000       |

  Scenario: Insert all information
    Given I add a student invoice
    When I fill up these invoice information
      | Field       | Value        | Type   |
      | Package     | Full Package | text   |
      | Season      | May 2014     | select |
      | Description | 50% Discount | text   |
      | Amount      | 17000        | text   |
      | Discount    | 0.5          | text   |
    * I submit the invoice form
    Then I should see these invoice information on the student invoice form
      | Full Package |
      | 50% Discount |
      | May 2014     |
      | 8,500        |

  Scenario: Remove an invoice
    Given there's a student invoice
    When I remove the invoice
    Then I should not see the invoice

  Scenario: Create transaction in an invoice
    Given there's a student invoice
    When I add a new transaction
    * I fill up these transaction information
      | Field  | Value      | Type |
      | date   | 2014-12-01 | text |
      | or_no  | 123456789  | text |
      | method | Cash       | text |
      | amount | 15000      | text |
    * I submit the transaction form
    Then the transaction is added to the invoice
    * I see the balance updated

  Scenario: Create empty transaction
    Given there's a student invoice
    When I add a new transaction
    * I submit the transaction form
    Then I should see 4 errors

  Scenario: Create and remove transaction in an invoice
    Given there's a student invoice
    When I add a new transaction
    * I fill up these transaction information
      | Field  | Value      | Type |
      | date   | 2014-12-01 | text |
      | or_no  | 123456789  | text |
      | method | Cash       | text |
      | amount | 15000      | text |
    * I submit the transaction form
    * I press the remove transaction button
    Then I should not see the transaction on the invoice