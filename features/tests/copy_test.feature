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