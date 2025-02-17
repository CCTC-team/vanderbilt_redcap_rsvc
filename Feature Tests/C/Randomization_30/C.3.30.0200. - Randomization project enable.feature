Feature: C.3.30.0200 User Interface: The system shall allow enabling/disabling Randomization at the project level.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

  Scenario: Randomization enabled
    #SETUP
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.0200.0100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "cdisc_files/Project 3.30 norand.REDCap.xml", and clicking the "Create Project" button
    #FUNCTIONAL_REQUIREMENT
    And I click on the button labeled "Enable" in the "Randomization module" row in the "Enable optional modules and customizations" section
    ##VERIFY C.3.30.0200.0100. Enabling adds randomization module to project setup
    ##VERIFY C.3.30.0200.0200. Enabling adds randomization module to application box
    Then I should see a button labeled "Disable" in the "Randomization module" row in the "Enable optional modules and customizations" section
    And I should see "Set up a randomization model"
  #While the "Set up a randomization model" button is visible, it will be disabled (greyed out).

  Scenario: ##VERIFY_log Randomization at project level enabled recorded in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Modify project settings                 |

  Scenario: C.3.30.0200.0300. Enabling adds randomization module options Setup, Dashboard, and Randomize to user rights privilege setup page.
    When I click on the link labeled "User Rights"
    ##VERIFY
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            |
      | —                       | test_user1          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |

    When I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"
    And I should see "Randomization"
    When  I check the checkbox labeled "Setup"
    And I check the checkbox labeled "Dashboard"
    And I check the checkbox labeled "Randomize"
    And I save changes within the context of User Rights
    #refresh
    Then I should see a link labeled "Randomization"

  Scenario: #SETUP Randomization 
  #C.3.30.0300.0100. User with Randomization Setup rights can use Randomization Module Setup Configuration page. 
    When I click on the link labeled "Randomization"
    ##VERIFY User with Randomization Setup rights can use Randomization Module Setup Configuration page.
    When I click on a button labeled "Add new randomization model"
    Then I should see  "STEP 1: Define your randomization model"

    When I select "rand_group" from the dropdown labeled "Choose your randomization field"
    And I click on the button labeled "Save randomizatoin module"
    And I upload a "csv" format file located at "import_files/AlloRand1.csv", by clicking the button near "Upload allocation table (CSV file) for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "Delete allocation table?"
    And I should see "Setup"
    And I should see "Dashboard"

    When I click the link labeled "Dashboard"
    Then I should see "table below displays the allocation dashboard"

  #C.3.30.0200.0600. Disabling removes randomization module options Setup, Dashboard, and Randomize to user rights privilege setup page.
  Scenario: Disable Randomization Dashboard
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"

    When  I check the checkbox labeled "Setup"
    And I uncheck the checkbox labeled "Dashboard"
    And I check the checkbox labeled "Randomize"
    And I save changes within the context of User Rights

    When I click on the link labeled "Randomization"
    Then I should see "Setup"
    And I should NOT see "Dashboard"

  Scenario: Disable Randomization Setup
 #C.3.30.0300.0200. User without Randomization Setup rights cannot use Randomization Module Setup Configuration page.
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"

    When  I uncheck the checkbox labeled "Setup"
    And I uncheck the checkbox labeled "Dashboard"
    And I check the checkbox labeled "Randomize"
    And I save changes within the context of User Rights

    When I click on the link labeled "Randomization"
    Then I should see "ACCESS DENIED!"
    And I should NOT see "Setup"
    And I should NOT see "Dashboard"
    #refresh
    #C.3.30.0200.0500. Disabling removes randomization module from application box.
    And i should NOT see "randomization"

  Scenario: C.3.30.0200.0400. Disabling removes randomization module from project setup
    When I click on the link labeled "Project Setup"
    Then I should see "Disable" in the "Randomization module" row in the "Enable optional modules and customizations" section

    When I click on the button labeled "Disable" in the "Randomization module" row in the "Enable optional modules and customizations" section
    ##VERIFY Randomization at project level disabled
    #refresh
    Then I should see "Enable" in the "Randomization module" row in the "Enable optional modules and customizations" section
    And I should NOT see "Set up a randomization model"
    And I logout
#END