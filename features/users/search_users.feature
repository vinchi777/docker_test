Feature: Search users

  Scenario: Search users with name or email
    When I am logged in as admin
    * users exists
    * I am on the users page
    Then I should be able to search users by name
      | Query     | Text             | Count | Notes                |
      | Joh       | dela Cruz, John  | 2     | Admin and first user |
      | yers      | Mayers, Erik     | 1     |                      |
      | dela Cruz | dela Cruz, Maria | 3     |                      |
    * I should be able to search users by email
      | Query       | Text            | Count |
      | yahoo       | dela Cruz, John | 2     |
      | erik_mayers | Mayers, Erik    | 1     |