Feature: E.125.2100 - NonRepeating_SingleArm_noDAGs

  As a REDCap end user
  I want to see that Enhance reason for change is functioning as expected

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
    And I should NOT see "Enhance reason for change - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Enhance reason for change"
    And I click on the button labeled "Enable" in the dialog box
    Then I should see "Enhance reason for change - v0.0.0"

    # E.125.700
    Given I click on the button labeled exactly "Configure"
    Then I should see "Configure Module" in the dialog box
    When I enter "Default Option 1" into the input field labeled "1. Provides a default option for the reason for change dropdown"
    And I click on the button labeled "+" in the dialog box
    When I enter "Default Option 2" into the input field labeled "2. Provides a default option for the reason for change dropdown"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Enhance reason for change - v0.0.0"

  Scenario: Enable external module in project
    Given I create a new project named "E.125.2100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/ProjectTypes/NonRepeating_SingleArm_noDAGs.xml", and clicking the "Create Project" button

    # ACTION: Import data
    Given I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "import_files/redcap_val/NonRepeating_SingleArm_noDAGs.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I should see "Your document was uploaded successfully and is ready for review."
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"

    # Enable reason for change
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Additional customizations"
    And I check the checkbox labeled Require a 'reason' when making changes to existing records in additional customizations
    Then I click on the button labeled "Save"

    # Non-repeating event
    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Text Validation" instrument on event "Event 2" for record ID "1" and click on the bubble
    And I clear field and enter "Name2" into the input field labeled "Name"
    And I click on the button labeled "Save & Exit Form"
    Then I should NOT see the field labeled "Name" with a colored right border
    And I should NOT see "Choose a standard reason or enter free text. Changing the selection will overwrite existing content." in the dialog box
    And I enter "Reason 1" into the textarea field labeled "Reason for changes:" in the dialog box
    And I click on the button labeled "Save" in the dialog box

    # Adding Test_User1 to DataEntryPI role
    Given I click on the link labeled "User Rights"
    When I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataEntryPI" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "DataEntryPI" row of the column labeled "Username" of the User Rights table

    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see "Enhance reason for change - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Enhance reason for change - v0.0.0"
    Then I should see "Enhance reason for change - v0.0.0"

    #VERIFY - E.125.700
    Given I click on the button labeled "Configure"
    Then I should see "Configure Module"
    When I check the checkbox labeled "When checked, a dropdown of reasons for change will be available for the user to select from"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Enhance reason for change - v0.0.0"
    And I logout

    # E.125.1200, E.125.1300
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.125.2100"
    When I click on the link labeled "Record Status Dashboard"
    And I should NOT see a link labeled exactly "Arm 1"
    And I should NOT see a link labeled exactly "Arm Two"
    And I should see a link labeled exactly "2"
    When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I clear field and enter "Name1" into the input field labeled "Name"
    And I click on the button labeled "Save & Exit Form"
    Then I should NOT see the field labeled "Name" with a colored right border
    And I should see "Choose a standard reason or enter free text. Changing the selection will overwrite existing content." in the dialog box
    And I select "Default Option 1" on the dropdown field labeled "Reason for changes"
    And I click on the button labeled "Save" in the dialog box
    And I logout

  Scenario: Verify different configuration settings
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.125.2100"
    When I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Configure"
    Then I should see "Configure Module" in the dialog box
    # E.125.2100
    And I enter "Option 3" into the input field labeled "1. Provide an option for the reason for change dropdown" in the dialog box
    And I click on the button labeled "+" in the dialog box
    And I enter "Option 4" into the input field labeled "2. Provide an option for the reason for change dropdown" in the dialog box
    # E.125.900
    And I check the checkbox labeled "When checked, any change to a field will highlight its row's right border" in the dialog box
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Enhance reason for change - v0.0.0"
    And I logout

    # E.125.1200, E.125.1300
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.125.2100"
    When I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I check the checkbox labeled "Checkbox2"
    And I click on the button labeled "Save & Exit Form"
    Then I should see the field labeled "Checkbox" with a 2px "solid" right border in "red" color
    Then I should see "Choose a standard reason or enter free text. Changing the selection will overwrite existing content." in the dialog box
    And I select "Option 3" on the dropdown field labeled "Reason for changes"
    And I click on the button labeled "Save" in the dialog box
    And I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.125.2100"
    When I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Configure"
    Then I should see "Configure Module" in the dialog box
    # E.125.1000
    When I enter "dashed 4px blue" into the input field labeled "The style to apply to the highlight border"
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Enhance reason for change - v0.0.0"

    # Add DataEntryPI with 'Project Setup & Design' rights
    Given I click on the link labeled "User Rights"
    When I click on the link labeled "DataEntryPI"
    Then I should see "Editing existing user role" in the dialog box
    And I check the User Right named "Project Setup & Design"
    Then I should see a checkbox labeled "Enhance reason for change" that is checked
    And I click on the button labeled "Save Changes"
    Then I should see "successfully edited"
    And I logout

    # E.125.1200, E.125.1300
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.125.2100"
    When I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 2" for record ID "1" and click on the bubble
    And I select "Choice101" on the radio field labeled "Radio Button Manual"
    Then I should see the field labeled "Radio Button Manual" with a 4px "dashed" right border in "blue" color
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Choose a standard reason or enter free text. Changing the selection will overwrite existing content." in the dialog box
    And I select "Option 4" on the dropdown field labeled "Reason for changes"
    And I click on the button labeled "Save" in the dialog box

    #VERIFY - E.125.1100 - Only Super-users can configure external Module
    Given I click on the link labeled exactly "Manage"
    Then I should see "Enhance reason for change - v0.0.0"
    And I should NOT see the button labeled "Disable"
    When I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    And I should NOT see "Hide this module from non-admins in the list of enabled modules on this project" in the dialog box
    And I should NOT see "When checked, a dropdown of reasons for change will be available for the user to select from" in the dialog box
    And I should NOT see "1. Provide an option for the reason for change dropdown" in the dialog box
    And I should NOT see "2. Provide an option for the reason for change dropdown" in the dialog box
    And I should NOT see "When checked, any change to a field will highlight its row's right border" in the dialog box
    And I should NOT see "The style to apply to the highlight border" in the dialog box
    Then I click on the button labeled "Cancel" in the dialog box
    And I logout

  Scenario: E.125.100 - Disable external module
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.125.2100"

    # Disable external module in project E.125.2100
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Enhance reason for change - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Enhance reason for change - v0.0.0"

    Given I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
      | Time / Date      | Username   | Action                      | List of Data Changes OR Fields Exported  | Reason for Data Change(s) |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "enhance_reason_for_change_v0.0.0" for project                  |                                                                                             |                           |
      | mm/dd/yyyy hh:mm | test_user1 | Update record 1 (Event 2) | radio_button_manual = '9..9'	             | Option 4                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "enhance_reason_for_change_v0.0.0" for project | highlight-field-when-changed-style                                                          |                           |
      | mm/dd/yyyy hh:mm | test_user1 | Update record 1 (Event 1) | checkbox(2) = checked	                     | Option 3                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "enhance_reason_for_change_v0.0.0" for project | reason-for-change-option, highlight-field-when-changed	                                   	|                           |
      | mm/dd/yyyy hh:mm | test_user1 | Update record 1 (Event 1) | ptname = 'Name1'                           | Default Option 1          |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "enhance_reason_for_change_v0.0.0" for project | provide-reasons-for-change-dropdown, reason-for-change-option, highlight-field-when-changed	|                           |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "enhance_reason_for_change_v0.0.0" for project                   |                                                                                             |                           |
      | mm/dd/yyyy hh:mm | test_admin | Update record 1 (Event 2) | ptname_v2 = 'Name2'                        | Reason 1                  |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    Then I should see "Enhance reason for change - v0.0.0"
    When I click on the button labeled "View Usage"
    Then I should see "None" in the dialog box
    And I should NOT see "E.125.2100" in the dialog box
    And I close the dialog box for the external module "Enhance reason for change"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Enhance reason for change - v0.0.0"

    # Not checking 'Delete Version' for now as this is used for deleting lower versions.
    # If the entire EM is deleted REDCap throws an error

    Given I click on the link labeled "User Activity Log"
    Then I should see a table header and row containing the following values in a table:
      | Time             | User       | Event                                                                                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "enhance_reason_for_change_v0.0.0" for system                   | 
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "enhance_reason_for_change_v0.0.0" for project                  | 
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "enhance_reason_for_change_v0.0.0" for project | 
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "enhance_reason_for_change_v0.0.0" for project                   | 
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "enhance_reason_for_change_v0.0.0" for system  | 
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "enhance_reason_for_change_v0.0.0" for system                    |    

    And I logout

    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - enhance_reason_for_change"