Feature: User Interface: The system shall restrict users to randomizing records only within their assigned DAG, in accordance with system-wide access controls.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

  Scenario: #SETUP project with no randomization enabled - "C.3.30 AllRandOptions.xml"
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.0600" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "C.3.30 AllRandOptions.xml", and clicking the "Create Project" button

  Scenario: #SETUP Randomization User Rights for User 1 (Give User all Rand Rights and Add User 2)
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit User Privileges"
    And I check the User Right named "Data Access Groups"
    And I check the User Right named "Setup"
    And I check the User Right named "Dashboard"
    And I check the User Right named "Randomize"
    And I save changes within the context of User Rights
    Then I should see a table header and rows containing the following values in a table:
      | Role name | Username   | Data Access Group |
      | —         | test_user1 |                   |

  Scenario: #SETUP Randomization User Rights User 2
    When I enter "Test_User2" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named "Randomize"
    And I save changes within the context of User Rights
    Then I should see a table header and rows containing the following values in a table:
      | Role name | Username   | Data Access Group |
      | —         | test_user1 |                   |
      | —         | test_user2 |                   |

  Scenario: #SETUP DAG with user 2
    When I click on the link labeled "DAGs"
    And I select "Test_User2" on the dropdown field labeled "Assign user"
    And I select "DAG 1" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups        | Users in group          |
      | DAG 1                     | test_user2              |
      | [Not assigned to a group] | test_user1 (Test User1) |

  Scenario: #SETUP Add a record 1 to DAG 1
    When I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    And I select "Assign to Data Access Group" on the dropdown field labeled "Choose action for record"
    And I select "DAG 1" on the dropdown field labeled "Assign record "1" to one of the following Data Access Groups:"
    And I click on the button labeled "Assign to Data Access Group"
    Then I should see "DAG 1"

  Scenario: #SETUP Upload randomization
    When I click on the link labeled "Randomization"
    And I click on the icon in the column labeled "Setup" in the row labeled "dag_rand"
    And I upload a "csv" format file located at "C.3.30.0600Allocation1.csv", by clicking the button near "Upload allocation table (CSV file) for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    #NOTE: Automation will have different DAG group ids from manual.  .csv may need to be modified to correct Group IDs based on instance. 
    And I click on the the link labeled "Project Home"
    And I logout

  Scenario: #SETUP Login to Test User 2
    Given I login to REDCap with the user "Test_User2"
    And I click "My Projects" on the menu bar
    And I click the link labeled "C.3.30.0600"

  Scenario: #FUNCTIONAL_REQUIREMENT C.3.30.0600.0100. Users within a DAG can randomize records only within their assigned DAG, ensuring they cannot view or randomize records outside their group.
#Users in a DAG can randomize records in their DAG
    When I click on the link labeled "Add / Edit Records"
    And I click the button "Add new record"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize" for the field labeled "Stratified by DAG Randomization"
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    And I click on the button labeled "Randomize"
    Then I should see a dialog containing the following text: "Randomizing Record ID"
    And I click on the button labeled "Close"
    Then I should see the radio field labeled "Stratified by DAG Randomization" with the option "Group 1" selected
    And I should see "Already Randomized" near the radio field labeled "Stratified by DAG Randomization"

  Scenario: #Users in a DAG can view randomization in their DAG
    When I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    Then I should see "Drug A" in the data entry form field "Randomization Group"
    And I should see "1" in the data entry form field "Blinded randomization"
    And I should see "Group 1" in the data entry form field "Automatic Randomization"

  Scenario: #Users in a DAG cannot view or randomize outside their DAG
    When I click on the link labeled "Add / Edit Records"
    And I click on the dropdown field labeled "Choose an existing Record ID"
    Then I should see the radio field labeled "Choose an existing Record ID" with the options below
      | "1"   |
      | "1-1" |
    And I should NOT see the radio field labeled "Choose an existing Record ID" WITHOUT the options below
      | "2" |
      | "3" |
      | "4" |
      | "5" |

  Scenario: #FUNCTIONAL_REQUIREMENT C.3.30.0600.0200: The randomization model shall support stratification by DAG, allowing independent randomization assignments within each DAG.
#Randomize a second record to DAG 1 (Group 2 is expected)
    When I click on the link labeled "Add / Edit Records"
    And I click the button "Add new record"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize" for the field labeled "Stratified by DAG Randomization"
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID "1-2" on the field Stratified by DAG Randomization (dag_rand)"
    And I click on the button labeled "Randomize"
    Then I should see a dialog containing the following text: "Record ID "1-2" was randomized for the field "Randomization group" and assigned the value "Group 2"(1)"
    And I click on the button labeled "Close"
    Then I should see the radio field labeled "Stratified by DAG Randomization" with the option "Group 2" selected
    And I should see "Already Randomized" near the radio field labeled "Stratified by DAG Randomization"
    And I logout

  Scenario: #Log in as Test User 1 and Randomize record 2 to DAG 2 - Group 3 is expected
    Given I login to REDCap with the user "Test_User1"
    And I click "My Projects" on the menu bar
    And I click the link labeled "C.3.30.0600"
    And I click on the link labeled "Add / Edit Records"
    And I select "2" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize" for the field labeled "Stratified by DAG Randomization"
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    And I select "DAG 2" on the dropdown field labeled "Assign record to a Data Access Group?"
    And I click on the button labeled "Randomize" for the field labeled "Stratified by DAG Randomization"
    Then I should see the dropdown field labeled "DAG 2" with the option "Group 3" selected
    And I click on the button labeled "Randomize"
    Then I should see a dialog containing the following text: "Record ID" was randomized for the field "Stratified by DAG Randomization" and assigned the value "Group 3" (3)."
    And I click on the button labeled "Close"

  Scenario: #Test User 1 and Randomize record 3 to DAG 2 - Group 2 is expected
    When I click on the link labeled "Add / Edit Records"
    And I select "3" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize" for the field labeled "Stratified by DAG Randomization"
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    And I select "DAG 2" on the dropdown field labeled "Assign record to a Data Access Group?"
    And I click on the button labeled "Randomize" for the field labeled "Stratified by DAG Randomization"
    Then I should see the dropdown field labeled "DAG 2" with the option "Group 3" selected
    And I click on the button labeled "Randomize"
    Then I should see a dialog containing the following text: "Record ID" was randomized for the field "Stratified by DAG Randomization" and assigned the value "Group 2" (2)."
    And I click on the button labeled "Close"

  Scenario: ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action           | List of Data Changes OR Fields Exported |
      | test_user1 | Randomize Record | Randomize record                        |
      | test_user2 | Randomize Record | Randomize record                        |
    And I logout
#END
