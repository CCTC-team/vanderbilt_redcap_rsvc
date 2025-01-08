Feature: C.3.30.0200 User Interface: The system shall allow enabling/disabling Randomization at the project level.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

  Scenario: #SETUP project with randomization enabled
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.0200.0100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 norand.REDCap.xml", and clicking the "Create Project" button

  Scenario: #FUNCTIONAL_REQUIREMENT C.3.30.0200.0100. Enabling adds randomization module to project setup
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Enable" in the "Randomization module" row in the "Enable optional modules and customizations" section
   
  Scenario: ##VERIFY C.3.30.0200.0200. Enabling adds randomization module to application box
    Then I should see a button labeled "Disable" in the "Randomization module" row in the "Enable optional modules and customizations" section
    #While the "Set up a randomization model" button is visible, it will be disabled (greyed out).
    And I should see "Set up a randomization model"
    And I should NOT see a link labeled "Randomization" 
    #This user's account doesn't have randomization rights.

  Scenario: ##VERIFY_log Randomization at project level enabled recorded in logging table
    When I click on the link labeled "Logging" 
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Modify project settings|

   Scenario: C.3.30.0200.0300. Enabling adds randomization module options Setup, Dashboard, and Randomize to user rights privilege setup page.
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
    

  Scenario: ##VERIFY options Setup, Dashboard, and Randomize in user rights privilege setup page.
    When I click on the link labeled "User Rights"
    And I click on the link labeled "1_FullRights"
    Then I should see "Randomization"
    And I should see a checkbox labeled "Setup" that is checked
    And I should see a checkbox labeled "Dashboard" that is checked
    And I should see a checkbox labeled "Randomize" that is checked
    And I click on the button labeled "Cancel"
    Then  I should see a link labeled "Randomization"

  Scenario: #FUNCTIONAL_REQUIREMENT Randomization module opens
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Set up randomization"
    Then I should see "Randomization"
    
  Scenario: C.3.30.0200.0400. Disabling removes randomization module from project setup
    When I click on the link labeled "Project Setup"
    Then I should see "Disable" in the "Randomization module" row in the "Enable optional modules and customizations" section
    When I click on the button labeled "Disable" in the "Randomization module" row in the "Enable optional modules and customizations" section

##VERIFY Randomization at project level disabled
    Then I should see "Enable" in the "Randomization module" row in the "Enable optional modules and customizations" section
    And I should NOT see "Set up a randomization model"

  Scenario: C.3.30.0200.0500. Disabling removes randomization module from application box.
    Then  I should NOT see a link labeled "Randomization"
    
  Scenario: ##VERIFY_log Randomization at project level enabled recorded in logging table
    When I click on the link labeled "Logging" 
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Modify project settings|

  Scenario: C.3.30.0200.0600. Disabling removes randomization module options Setup, Dashboard, and Randomize to user rights privilege setup page.
    When I click on the link labeled "User Rights"
    And I click on the link labeled "1_FullRights"
##VERIFY options Setup, Dashboard, and Randomize NOT in user rights privilege setup page.
    Then I should NOT see "Randomization"
    And I should NOT see a checkbox labeled "Setup"
    And I should NOT see a checkbox labeled "Dashboard"
    And I should NOT see a checkbox labeled "Randomize"
    And I click on the button labeled "Cancel"
    And I logout
#END