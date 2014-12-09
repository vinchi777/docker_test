Feature: Delete review season

  Background:
    Given a review season exists
    * I am logged in as admin
    * I am on the review seasons page

  Scenario: Successfully delete season
    When I remove a review season
    Then I should not see the review season

  Scenario: Cancels delete season
    When I cancel the removal of a review season
    Then I should see the review season