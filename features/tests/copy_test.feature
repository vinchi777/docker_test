Feature: Copy test from existing test

  Scenario: Copy test from last season test
    Given past review season exists
    * current review season exists
    * a test from last season exists
    * I am logged in as admin
    * I am on the test page
    Then I should see "Copy to Current Season"
    When I click on "Copy to Current Season"
    Then a duplicated test should be created
    * I should be on the duplicated test page

  Scenario: Disable copying of test when in current season
    Given I am logged in as admin
    When a test exists
    * I am on the test page
    Then I should not see "Copy to Current Season"

  Scenario: Disable copying of test already duplicated
    Given I am logged in as admin
    * past review season exists
    * current review season exists
    * a test from last season exists
    * the test is duplicated to the current season
    When I am on the test page
    Then I should not see "Copy to Current Season"