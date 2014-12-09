Feature: Student list for public viewing

  Background:
    Given students exist
    * I am on the home page

  Scenario: Visiting our students page
    When I click the people dropdown
    * I click the "Students" link
    Then I should see 2 students in our students page
