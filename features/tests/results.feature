Feature: Show results

  Background:
    Given I am logged in as admin
    * a review season exists
    * enrolled students exists for the current season
    * a test exists and published
    When students take the exam
    * I wait until the deadline
    * I am on the tests page
    * I click on "Results"
    Then I can see passing rate
    * I can see students score