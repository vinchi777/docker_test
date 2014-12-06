Feature: Add student payment

  Background:
    Given I am logged in as admin
    * A review season exists
    * there are existing students

  Scenario: Insert required information
    Given I add a student invoice
    When I fill up these invoice information
      | package | Full Package | text   |
      | season  | May 2014     | select |
      | amount  | 17000        | text   |
    * I submit the invoice form
    Then I should see these invoice information on the student invoice form
      | Full Package |
      | May 2014     |
      | 17,000       |

  Scenario: Insert all information
    Given I add a student invoice
    When I fill up these invoice information
      | package     | Full Package | text   |
      | season      | May 2014     | select |
      | description | 50% Discount | text   |
      | amount      | 17000        | text   |
      | discount    | 0.5          | text   |
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
      | date   | 2014-12-01 |
      | or_no  | 123456789  |
      | method | Cash       |
      | amount | 15000      |
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
      | date   | 2014-12-01 |
      | or_no  | 123456789  |
      | method | Cash       |
      | amount | 15000      |
    * I submit the transaction form
    * I press the remove transaction button
    Then I should not see the transaction on the invoice