Feature: List of founders, reviewers and students for public viewing

  Background:
    Given I am on the home page

  Scenario: Visiting our students page
    Given students exist
    When I click the people dropdown
    * I click the "Students" link
    Then I should see 2 students in our students page

  Scenario: Visit founders page
    When I click the people dropdown
    * I click the "Founders" link
    Then I should see the following founders
      | Name                          | Position                                           |
      | Rommel D. Capungcol           | President                                          |
      | Jose Van P. Tan               | Vice President and Treasurer                       |
      | Mariel C. Villaflor-Capungcol | Co-Owner                                           |
      | Christine Almedilla-Pablico   | Review Specialist and Head of Accounting           |
      | Cesar Czarbo P. Trani         | Review Specialist and Head of Marketing            |
      | Menardo Lim                   | Review Specialist and Head of Program and Planning |

  Scenario: Visit reviewers page
    When I click the people dropdown
    * I click the "Reviewers" link
    Then I should see the following reviewers
      | Name                      | Position                     |
      | Alvin Andrade             | RN, MAN                      |
      | Christian Paul Biluan     | RN, USRN, MAN                |
      | Diana Mahinay             | RN, MAN, phD                 |
      | Dindo De Guzman           | DMD, RN, USRN, PhDBiochem    |
      | Elenita Arreglo           | RN, MD, MAN                  |
      | Ernest Jourdan Flaminiano | RN, MAN                      |
      | Gilbert Marzan            | RN, MAN                      |
      | John Patrick Jacomille    | RN, MAN                      |
      | Mark Billy Perpetua       | RN, MAN                      |
      | Mary Anne Charry Te       | RN, USRN, MAN                |
      | Robert Joseph Seguin      | RN, MAN                      |
      | Roland Villegas           | RN, MAN, Review Center Owner |
