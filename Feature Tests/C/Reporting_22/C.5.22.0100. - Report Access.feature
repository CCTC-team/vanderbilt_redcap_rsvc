Feature: User Interface: The system shall support the ability to assign the User Access to View Access and Edit Access in the Reporting module
    As a REDCap end user
    I want to see that Reporting is functioning as expected

  Scenario: C.5.22.100.100 - MISSING SCENARIO TITLE
        #SETUP
    Given I login to REDCap with the user "Test_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
    And I create a new project named "C.5.22.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

  Scenario: #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

  Scenario: #USER_RIGHTS User 1 Dag 1
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I select "TestGroup1" on the dropdown field labeled "Assign To DAG" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            | Data Access Group |
      | —                       | test_admin          |                   |
      |            1_FullRights | test_user1          | TestGroup1        |
      |         2_Edit_RemoveID | [No users assigned] |                   |
      | 3_ReadOnly_Deidentified | [No users assigned] |                   |
      |     4_NoAccess_Noexport | [No users assigned] |                   |
      | TestRole                | [No users assigned] |                   |

  Scenario: #SETUP: Assign record 2 to DAG2
    When I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "2_Edit_RemoveID" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I select "TestGroup2" on the dropdown field labeled "Assign To DAG" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    And I should see a table header and rows containing the following values in a table:
      | Role name               | Username            | Data Access Group |
      | —                       | test_admin          |                   |
      |            1_FullRights | test_user1          | TestGroup1        |
      |         2_Edit_RemoveID | test_user2          | TestGroup2        |
      | 3_ReadOnly_Deidentified | [No users assigned] |                   |
      |     4_NoAccess_Noexport | [No users assigned] |                   |
      | TestRole                | [No users assigned] |                   |

  Scenario: Add User 3 in No Role and No DAG
    When I enter "Test_User3" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I uncheck the checkbox labeled "Add/Edit/Organize Reports"
    And I click on the button labeled "Add user"
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            | Data Access Group |
      | —                       | test_admin          |                   |
      | —                       | test_user3          |                   |
      |            1_FullRights | test_user1          | TestGroup1        |
      |         2_Edit_RemoveID | test_user2          | TestGroup2        |
      | 3_ReadOnly_Deidentified | [No users assigned] |                   |
      |     4_NoAccess_Noexport | [No users assigned] |                   |
      | TestRole                | [No users assigned] |                   |

  Scenario: #SETUP: Create report
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Create New Report"
    And I enter "C.5.22.100.100 REPORT" into the input field labeled "Name of Report:"
     #FUNCTIONAL_REQUIREMENT
    And I select the radio button labeled "All users" is selected for the field labeled "View Access"
    And I select the radio button labeled "All users" is selected for the field labeled "Edit Access"
    And I click on the button labeled "Save Report"
    Then I should see "Your report has been saved!" in the dialog box
    When I click on the button labeled "Return to My Reports & Exports"
    And I logout

  Scenario: ##VERIFY: USER 1
    Given I login to REDCap with the user "Test_User1"
    Then I should see a table row containing the following values in the reports table:
      | 1 | C.5.22.100.100 REPORT |
    When I click on the "View Report" button for the "C.5.22.100.100 REPORT" report in the My Reports & Exports table
    Then I should see a table header and rows containing the following values in a table:
      | Record ID     | Event Name                 | Repeat Instance |
      | 1  TestGroup1 | Event 1 (Arm 1: Arm 1)     |                 |
      | 1  TestGroup1 | Event Three (Arm 1: Arm 1) |                 |
      | 1  TestGroup1 | Event 2 (Arm 1: Arm 1)     |               1 |
      | 1  TestGroup1 | Event 2 (Arm 1: Arm 1)     |               2 |
    ##VERIFY: Edit Report button
    And I should see a button labeled "Edit Report"
    And I logout

  Scenario: ##VERIFY: USER 2
    Given I login to REDCap with the user "Test_User2"
    Then I should see a table row containing the following values in the reports table:
      | 1 | C.5.22.100.100 REPORT |
    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in a table:
      | Record ID     | Event Name             | Repeat Instance |
      | 2  TestGroup2 | Event 1 (Arm 1: Arm 1) |                 |
    ##VERIFY: Edit Report button
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the "Edit" button for the "C.5.22.100.100 REPORT" report in the My Reports & Exports table
    And I logout

  Scenario: ##VERIFY: USER 3
    Given I login to REDCap with the user "Test_User3"
    And I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see the link labeled "C.5.22.100.100 REPORT"
    ##VERIFY: cannot create report, edit, delete or copy report
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should NOT see a button labeled "Edit"
    And I should NOT see a button labeled "Copy"
    And I should NOT see a button labeled "Delete"
    And I should see a table row containing the following values in the reports table:
      | 1 | C.5.22.100.100 REPORT |
    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in a table:
      | Record ID | Event Name                 | Repeat Instance |
      |         1 | Event 1 (Arm 1: Arm 1)     |                 |
      |         1 | Event Three (Arm 1: Arm 1) |                 |
      |         1 | Event 2 (Arm 1: Arm 1)     |               1 |
      |         1 | Event 2 (Arm 1: Arm 1)     |               2 |
      |         2 | Event 1 (Arm 1: Arm 1)     |                 |
      |         3 | Event 1 (Arm 1: Arm 1)     |                 |
      |         4 | Event 1 (Arm 1: Arm 1)     |                 |
    ##VERIFY: Edit Report button
    And I should NOT see a button labeled "Edit Report"
    And I logout

  Scenario: #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the "Edit" button for the "C.5.22.100.100 REPORT" report in the My Reports & Exports table

  Scenario: #FUNCTIONAL_REQUIREMENT
    When I select the radio option "Custom user access" for the field labeled "View Access"
    And I select "test_user1" on the dropdown field labeled "Selected users"
    And I select "test_user2" on the dropdown field labeled "Selected users"
    And I select the radio option "Custom user access" for the field labeled "Edit Access"
    And I select "test_user1" on the dropdown field labeled "Selected users"
    And I click on the button labeled "Save Report"
    Then I should see "Your report has been saved!" in the dialog box
    And I click on the button labeled "Return to My Reports & Exports"
    And I logout

  Scenario: ##VERIFY: USER 3
    Given I login to REDCap with the user "Test_User3"
    And I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should NOT see the link labeled "C.5.22.100.100 REPORT"
    And I logout

  Scenario: ##VERIFY: USER 2
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | 2 | C.5.22.100.100 REPORT |
    And I should NOT see a button labeled "Edit" for the row labeled "2"
    And I should NOT see a button labeled "Copy" for the row labeled "2"
    And I should NOT see a button labeled "Delete" for the row labeled "2"
    #VERIFY Report
    When I click on the button labeled "View Report" for the link labeled "C.5.22.100.100 REPORT"
    Then I should see a table header and rows containing the following values in a table:
      | Record ID     | Event Name             | Repeat Instance |
      | 2  TestGroup2 | Event 1 (Arm 1: Arm 1) |                 |
        ##VERIFY: Edit Report button
    And I should NOT see a button labeled "Edit Report"
    And I logout

  Scenario: ##VERIFY: USER 1
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | 2 | C.5.22.100.100 REPORT |
    And I should see a button labeled "Edit" for the row labeled "2"
    And I should see a button labeled "Copy" for the row labeled "2"
    And I should see a button labeled "Delete" for the row labeled "2"
      #VERIFY Report
    When I click on the button labeled "View Report" for the link labeled "C.5.22.100.100 REPORT"
    Then I should see record "1"
    And I should NOT see record "2"
    And I should NOT see record "3"
    And I should NOT see record "4"
        ##VERIFY: Edit Report button
    And I should see a button labeled "Edit Report"
    And I logout
#END
