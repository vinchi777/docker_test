Feature: Add review season

  Background:
    Given I am logged in as admin
    * I am on the review seasons page
    When I press the "Create Review Season" button

  Scenario: Add required fields
    When I fill up these Review Season information
      | Field         | Value         | Type |
      | Season        | May 2014      | text |
      | Season Start  | Apr. 1, 2014  | text |
      | Season End    | Apr. 15, 2014 | text |
      | Full Review   | 15000         | text |
      | Double Review | 22000         | text |
      | Coaching      | 7000          | text |
      | Reservation   | 3000          | text |
    * I press the "Add Review Season" button
    Then I should not see any modal
    * the review season is persisted

  Scenario: Add all fields
    When I fill up these Review Season information
      | Field         | Value         | Type |
      | Season        | May 2014      | text |
      | Season Start  | Apr. 1, 2014  | text |
      | Season End    | Apr. 15, 2014 | text |
      | Promo Start   | Mar. 20, 2014 | text |
      | Promo End     | Mar. 30, 2014 | text |
      | Full Review   | 15000         | text |
      | Double Review | 22000         | text |
      | Coaching      | 7000          | text |
      | Reservation   | 3000          | text |
      | Repeater      | 19000         | text |
      | First Timer   | 7000          | text |
    * I press the "Add Review Season" button
    Then I should not see any modal
    * the review season is persisted

  Scenario: No filled up fields
    When I press the "Add Review Season" button
    Then I should see 8 errors

  Scenario: Invalid fields
    When I fill up these Review Season information
      | Field         | Value         | Type | Note                  |
      | Season        | ma            | text | Min length is 3       |
      | Season Start  | Apr. 15, 2014 | text |                       |
      | Season End    | Apr. 1, 2014  | text | Wrong date precedence |
      | Promo Start   | Mar. 20, 2014 | text | Promo end missing     |
      | Full Review   | 0             | text | Min value > 0         |
      | Double Review | 1000000       | text | Max value < 1,000,000 |
      | Coaching      | -1            | text | Must be positive      |
      | Reservation   | abc           | text | Must be a number      |
    * I press the "Add Review Season" button
    Then I should see 7 errors