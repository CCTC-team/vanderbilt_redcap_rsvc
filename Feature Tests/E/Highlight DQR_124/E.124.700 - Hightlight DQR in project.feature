Feature: E.124.700 - The system shall support the ability to view data quality errors in instruments based on user roles using Highlight DQ Rules external module.

  As a REDCap end user
  I want to see that Highlight DQ Rules External Module work as expected

  Scenario: Enable external Module from Control Center
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    # EMAIL ADDRESS SET FOR REDCAP ADMIN - without it, emails are not send out from system
    When I click on the link labeled "General Configuration"
    Then I should see "General Configuration"
    When I enter "redcap@test.instance" into the input field labeled "Email Address of REDCap Administrator"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"

    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Module Manager"
    And I should NOT see "Highlight DQ Rules - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Highlight DQ Rules"
    And I click on the button labeled "Enable" in the dialog box
    Then I should see "Highlight DQ Rules - v0.0.0"
 
  Scenario: Enable external module in project
    Given I create a new project named "E.124.700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_nodata.xml", and clicking the "Create Project" button
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Highlight DQ Rules - v0.0.0"
    Then I should see "Highlight DQ Rules - v0.0.0"

    # Configure external Module
    Given I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    When I select "DataManager" on the dropdown field labeled "1. A role that can view the highlight DQ rule errors"
    And I click on the button labeled "+" in the dialog box
    When I select "Monitor" on the dropdown field labeled "2. A role that can view the highlight DQ rule errors"
    Then I click on the button labeled "Save" in the dialog box
    Then I should see "Highlight DQ Rules - v0.0.0"

    # Add User Test_User1 with 'Project Setup & Design' rights
    Given I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I check the User Right named "Project Setup & Design"
    Then I should see a checkbox labeled "Highlight DQ Rules" that is checked
    And I click on the button labeled "Add user"
    Then I should see "successfully added"

    # Add User Test_User2 to DataManager user role
    Given I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataManager" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User2" within the "DataManager" row of the column labeled "Username" of the User Rights table
    
    # Add User Test_User3 to Monitor user role
    Given I enter "Test_User3" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "Monitor" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User3" within the "Monitor" row of the column labeled "Username" of the User Rights table
   
    # Add User Test_User4 to DataEntry user role
    Given I enter "Test_User4" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataEntry" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User4" within the "DataEntry" row of the column labeled "Username" of the User Rights table
   
    #ACTION: Import data 
    Given I click on the link labeled "Data Import Tool"
    And  I upload a "csv" format file located at "import_files/redcap_val/E124700_Data_Import.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I should see "Your document was uploaded successfully and is ready for review."
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
    And I logout

  Scenario: E.124.1000, E.124.1100 - Highlight DQ Rules for Repeating Instruments in Arm 1
    #VERIFY - E.124.700 - DataManager can view DQR
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.700"

    #Repeating Instrument - Instance #1
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I click on the tab labeled "Arm 1"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click the repeating instrument bubble for the first instance
    Then I should see "Data Types"
    And I should see "(Instance #1)"
    And I should see "Data quality errors for current form"
    And I should see "Identifier more than 8" in the Data quality error table
    And I should see "[identifier] > 8" in the Data quality error table
    And I should NOT see the field labeled "Identifier" highlighed in red
    When I click on the link labeled "Identifier more than 8"
    Then I should see "Data Quality Rules"
    And I should see "Identifier more than 8"
    And I should see "[identifier] > 8"

    #Repeating Instrument - Instance #2
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click the repeating instrument bubble for the second instance
    Then I should see "Data Types"
    And I should see "(Instance #2)"
    And I should NOT see "Data quality errors for current form"
    And I should NOT see "Identifier more than 8"
    And I should NOT see "[identifier] > 8"
    And I should NOT see the field labeled "Identifier" highlighed in red

    #Repeating Instrument - Instance #3
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click the repeating instrument bubble for the third instance
    Then I should see "Data Types"
    And I should see "(Instance #3)"
    And I should see "Data quality errors for current form"
    And I should see "Identifier more than 8" in the Data quality error table
    And I should see "[identifier] > 8" in the Data quality error table
    And I should NOT see the field labeled "Identifier" highlighed in red
    And I logout

    #VERIFY - E.124.900 - Super-users can configure the settings
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.700"
    Then I should see "Project Home and Design"
    When I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I click on the button labeled "Configure"
    Then I should see "Configure Module"
    And I check the checkbox labeled "When checked, shows the data quality rule error in line with the question" in the dialog box
    When I click on the button labeled "Save" in the dialog box
    Then I should see "Highlight DQ Rules - v0.0.0"
    And I logout

  Scenario: E.124.1000, E.124.1100 - Highlight DQ Rules for Repeating Events in Arm 2
    #VERIFY - E.124.700 - Monitor can view DQR
    Given I login to REDCap with the user "Test_User3"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.700"

    #Repeating Event - Instance #1
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I click on the tab labeled "Arm 2"
    And I click on the link labeled exactly "2"
    When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    # And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "(#1)"
    Then I should see "Data Types"
    And I should NOT see "Data quality errors for current form"
    And I should NOT see "Identifier more than 8"
    And I should NOT see "[identifier] > 8"
    # VERIFY - E.124.800
    And I should NOT see the field labeled "Identifier" highlighed in red

    #Repeating Event - Instance #2
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I click on the tab labeled "Arm 2"
    And I click on the link labeled exactly "2"
    When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "(#2)"
    Then I should see "Data Types"
    And I should see "(Instance #2)"
    And I should see "Data quality errors for current form"
    And I should see "Identifier more than 8" in the Data quality error table
    And I should see "[identifier] > 8" in the Data quality error table
    And I should see the field labeled "Identifier" highlighed in red

    #Repeating Event - Instance #3
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I click on the tab labeled "Arm 2"
    And I click on the link labeled exactly "2"
    When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "(#3)"
    Then I should see "Data Types"
    And I should see "(Instance #3)"
    And I should see "Data quality errors for current form"
    And I should see "Identifier more than 8" in the Data quality error table
    And I should see "[identifier] > 8" in the Data quality error table
    And I should see the field labeled "Identifier" highlighed in red
    And I logout

  Scenario: E.124.900 - non-Super-users cannot configure the Highlight DQ Rules project configurations 
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.700"
    Then I should see "Project Home and Design"
    When I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see the button labeled "Disable"
    And I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    And I should NOT see "Hide this module from non-admins in the list of enabled modules on this project" in the dialog box
    And I should NOT see "A role that can view the highlight DQ rule errors" in the dialog box
    And I should NOT see "When checked, shows the data quality rule error in line with the question" in the dialog box
    When I click on the button labeled "Cancel" in the dialog box
    Then I should see "Highlight DQ Rules - v0.0.0"
    And I should see "Currently Enabled Modules"

    Given I click on the link labeled "Record Status Dashboard"
    When I click on the tab labeled "Arm 1"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click the repeating instrument bubble for the first instance
    Then I should see "Data Types"
    And I should see "(Instance #1)"
    And I should NOT see "Data quality errors for current form"
    And I should NOT see "Identifier more than 8"
    And I should NOT see "[identifier] > 8"
    And I should NOT see the field labeled "Identifier" highlighed in red
    And I logout

    #VERIFY - E.124.700 - DataEntry cannot view DQR
    Given I login to REDCap with the user "Test_User4"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.700"
  
    Given I click on the link labeled "Record Status Dashboard"
    When I click on the tab labeled "Arm 1"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click the repeating instrument bubble for the first instance
    Then I should see "Data Types"
    And I should see "(Instance #1)"
    And I should NOT see "Data quality errors for current form"
    And I should NOT see "Identifier more than 8"
    And I should NOT see "[identifier] > 8"
    And I should NOT see the field labeled "Identifier" highlighed in red
    And I logout

  Scenario: E.124.100 - Disable external module
    # Disable external module in project
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.700"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Highlight DQ Rules - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Highlight DQ Rules - v0.0.0"

    Given I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
      | Time / Date      | Username   | Action                                                                           | List of Data Changes OR Fields Exported                                                 |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "highlight_dq_rules_v0.0.0" for project                  |                                                                                         |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "highlight_dq_rules_v0.0.0" for project | highlight-dq-inline                                                                     |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "highlight_dq_rules_v0.0.0" for project | reserved-hide-from-non-admins-in-project-list, user-roles-can-view, highlight-dq-inline |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "highlight_dq_rules_v0.0.0" for project                   |                                                                                         |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Highlight DQ Rules - v0.0.0"

    # Not checking 'Delete Version' for now as this is used for deleting lower versions.
    # If the entire EM is deleted REDCap throws an error

    Given I click on the link labeled "User Activity Log"
    Then I should see a table header and row containing the following values in a table:
      | Time             | User       | Event                                                                            |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "highlight_dq_rules_v0.0.0" for system                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "highlight_dq_rules_v0.0.0" for project                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "highlight_dq_rules_v0.0.0" for project |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "highlight_dq_rules_v0.0.0" for project                   |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "highlight_dq_rules_v0.0.0" for system                    |

    And I logout

    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - highlight_dq_rules"