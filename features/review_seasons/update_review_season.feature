Feature: Update review season

  Background:
    Given a review season exists
    * I am logged in as admin
    * I am on the review seasons page
    * I click the update button of a review season

  Scenario: Edit with valid fields
    When I fill up these Review Season information
      | Field         | Value         | Type |
      | Season        | July 2014     | text |
      | Season Start  | Jun. 1, 2014  | text |
      | Season End    | Jun. 15, 2014 | text |
      | Full Review   | 7000          | text |
      | Double Review | 11000         | text |
      | Coaching      | 5000          | text |
      | Reservation   | 2000          | text |
    * I press the "Update Review Season" button
    Then the review season should be updated
    * I should not see any modal

  Scenario: Edit with invalid fields
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
    * I press the "Update Review Season" button
    Then I should see 7 errors