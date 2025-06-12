Feature: E.126.2800 - NonLongitudinal_RepeatingInstruments_noDAGS

  As a REDCap end user
  I want to see that Enhance form status is functioning as expected

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
    And I should NOT see "Enhance form status - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Enhance form status"
    And I click on the button labeled "Enable" in the dialog box
    Then I should see "Enhance form status - v0.0.0"
 
  Scenario: Enable external module in project
    Given I create a new project named "E.126.2800" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/ProjectTypes/NonLongitudinal_RepeatingInstruments_noDAGS.xml", and clicking the "Create Project" button
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see "Enhance form status - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Enhance form status - v0.0.0"
    Then I should see "Enhance form status - v0.0.0"

    # Adding Test_User1 to DataEntryPI role and DAG1
    Given I click on the link labeled "User Rights"
    When I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataEntryPI" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "DataEntryPI" row of the column labeled "Username" of the User Rights table

    # Adding Test_User2 to DataEntryPI role and DAG2
    Given I click on the link labeled "User Rights"
    When I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataEntryPI" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User2" within the "DataEntryPI" row of the column labeled "Username" of the User Rights table

    # Adding Test_User3 to DataManager role
    When I enter "Test_User3" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataManager" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User3" within the "DataManager" row of the column labeled "Username" of the User Rights table

    # ACTION: Import data
    Given I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "import_files/redcap_val/NonLongitudinal_RepeatingInstruments_noDAGS.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I should see "Your document was uploaded successfully and is ready for review."
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"

    # E.126.800, E.126.900
    And I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Configure"
    Then I should see "Configure Module" in the dialog box
    And I select "DataManager" on the dropdown field labeled "1. Roles that can update the form status" in the dialog box
    And I select "DataEntryPI" on the dropdown field labeled "1. Roles that can view the form status" in the dialog box
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Enhance form status - v0.0.0"
    And I logout

    # User can view/(Not update) Form Status
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.126.2800"
    And I click on the link labeled "Add / Edit Records"
    When I click on the button labeled "Add new record"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Status"
    # And I should NOT see "Form Status"
    And I should NOT see "Complete?"
    And I should NOT see "Incomplete"
    And I should NOT see red form status bubble
    # And I should NOT see a button labeled "Set incomplete"
    And I should NOT see a button labeled "Set complete"
    And I should NOT see a button labeled "Set unverified"
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see red bubble with the form status "Incomplete"

    Given I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I should see a link labeled exactly "2"
    When I locate the bubble for the "Data Types" instrument for record ID "1" and click the repeating instrument bubble for the second instance
    Then I should see green bubble with the form status "Complete"
    # And I should NOT see "Form Status"
    And I should NOT see "Complete?"
    And I should NOT see "Incomplete"
    # And I should NOT see a button labeled "Set incomplete"
    And I should NOT see a button labeled "Set complete"
    And I should NOT see a button labeled "Set unverified"
    And I logout

    # User can View/Update Form Status
    # Readonly Access for all instrument
    Given I login to REDCap with the user "Test_User3"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.126.2800"
    And I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument for record ID "1" and click the repeating instrument bubble for the first instance
    # And I should NOT see "Form Status"
    And I should NOT see "Complete?"
    And I should see "Incomplete"
    And I should see red bubble with the form status "Incomplete"
    # And I should see a button labeled "Set incomplete"
    And I should see a button labeled "Set complete"
    And I should see a button labeled "Set unverified"
    When I click on the button labeled "Set unverified"
    Then I should see yellow bubble with the form status "Unverified"
  
    # Given I click on the link labeled "Text Validation"
    # Then I should see green bubble with the form status "Complete"
    # When I click on the button labeled "Set incomplete"
    # Then I should see red bubble with the form status "Incomplete"

    # E.126.1300, E.126.1400
    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument for record ID "2" and click the repeating instrument bubble for the second instance
    Then I should see red bubble with the form status "Incomplete"
    When I click on the button labeled "Set complete"
    Then I should see green bubble with the form status "Complete"
    And I logout

    # Add DataEntryPI with 'Project Setup & Design' rights
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.126.2800"
    Given I click on the link labeled "User Rights"
    When I click on the link labeled "DataEntryPI"
    Then I should see "Editing existing user role" in the dialog box
    And I check the User Right named "Project Setup & Design"
    Then I should see a checkbox labeled "Enhance form status" that is checked
    And I click on the button labeled "Save Changes"
    Then I should see "successfully edited"

    # E.126.700, E.126.1000, E.126.1100
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    When I select "always show the form status in the data entry form footer" on the dropdown field labeled "The form status will be attached to the foot of the data entry form"
    And I enter "in-progress" into the input field labeled "Text that should replace 'unverified' in the form status" in the dialog box
    And I enter "@EXCLUDE" into the input field labeled "An action tag that users can use to exclude a field from the automatic invalidation of the form status" in the dialog box
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Enhance form status - v0.0.0"
    And I logout

    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.126.2800"

    #VERIFY - E.126.1200 - Only Super-users can configure external Module
    Given I click on the link labeled exactly "Manage"
    Then I should see "Enhance form status - v0.0.0"
    And I should NOT see the button labeled "Disable"
    When I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    And I should NOT see "Hide this module from non-admins in the list of enabled modules on this project" in the dialog box
    And I should NOT see "The form status will be attached to the foot of the data entry form" in the dialog box
    And I should NOT see "1. Roles that can update the form status" in the dialog box
    And I should NOT see "1. Roles that can view the form status" in the dialog box
    And I should NOT see "2. Roles that can view the form status" in the dialog box
    And I should NOT see "Text that should replace 'unverified' in the form status" in the dialog box
    And I should NOT see "An action tag that users can use to exclude a field from the automatic invalidation of the form status" in the dialog box
    And I click on the button labeled "Cancel" in the dialog box
    Then I should see "Enhance form status - v0.0.0"

    # Verify E.126.1000, E.126.1100
    Given I click on the link labeled "Record Status Dashboard"
    Then I should see a link labeled exactly "1"
    When I locate the bubble for the "Data Types" instrument for record ID "2" and click the repeating instrument bubble for the second instance
    Then I should NOT see a button labeled "Set in-progress"
    And I should NOT see a button labeled "Set complete"
    # And I should NOT see a button labeled "Set incomplete"
    And I should NOT see a button labeled "Set unverified"
    Then I should see green bubble with the form status "Complete"
    And I enter "ABC" into the textarea field labeled "Notes Box"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see green bubble with the form status "Complete"
    When I clear field and enter "ABC" into the input field labeled "Name"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see yellow bubble with the form status "in-progress"
    And I logout

    Given I login to REDCap with the user "Test_User3"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.126.2800"
    When I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument for record ID "2" and click the repeating instrument bubble for the second instance
    # And I should NOT see "Form Status"
    And I should NOT see "Complete?"
    And I should see yellow bubble with the form status "in-progress"
    # And I should see a button labeled "Set incomplete"
    And I should see a button labeled "Set complete"
    # Verify E.126.1000
    And I should see a button labeled "Set in-progress"
    And I should NOT see a button labeled "Set unverified"
    And I logout

    # E.126.700
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.126.2800"
    When I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    When I select "never show the form status in the data entry form footer" on the dropdown field labeled "The form status will be attached to the foot of the data entry form"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Enhance form status - v0.0.0"

    # Verify E.126.700
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.126.2800"
    When I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument for record ID "2" and click the repeating instrument bubble for the second instance
    # And I should NOT see "Form Status"
    And I should NOT see "Complete?"
    And I should NOT see yellow form status bubble
    And I logout

    # Verify E.126.700
    Given I login to REDCap with the user "Test_User3"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.126.2800"
    When I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument for record ID "2" and click the repeating instrument bubble for the second instance
    # Then I should NOT see a button labeled "Set incomplete"
    And I should NOT see a button labeled "Set complete"
    And I should NOT see a button labeled "Set in-progress"
    # And I should NOT see "Form Status"
    And I should NOT see "Complete?"
    Then I should NOT see yellow form status bubble
    And I logout

  Scenario: E.126.100 - Disable external module
    # Disable external module in project
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.126.2800"
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Enhance form status - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Enhance form status - v0.0.0"

    Given I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
      | Time / Date      | Username   | Action                                                                            | List of Data Changes OR Fields Exported                                                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "enhance_form_status_v0.0.0" for project                  |                                                                                           |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "enhance_form_status_v0.0.0" for project | show-form-status-inline                                                                   |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "enhance_form_status_v0.0.0" for project | show-form-status-inline, text-representing-in-progress, ignore-for-form-status-check      |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "enhance_form_status_v0.0.0" for project | reserved-hide-from-non-admins-in-project-list, user-roles-can-update, user-roles-can-view |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "enhance_form_status_v0.0.0" for project                   |                                                                                           |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    Then I should see "Enhance form status - v0.0.0"
    When I click on the button labeled "View Usage"
    Then I should see "None" in the dialog box
    And I should NOT see "E.126.2800" in the dialog box
    And I close the dialog box for the external module "Enhance form status"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Enhance form status - v0.0.0"

    # Not checking 'Delete Version' for now as this is used for deleting lower versions.
    # If the entire EM is deleted REDCap throws an error

    Given I click on the link labeled "User Activity Log"
    Then I should see a table header and row containing the following values in a table:
      | Time             | User       | Event                                                                             |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "enhance_form_status_v0.0.0" for system                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "enhance_form_status_v0.0.0" for project                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "enhance_form_status_v0.0.0" for project |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "enhance_form_status_v0.0.0" for project                   |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "enhance_form_status_v0.0.0" for system                    |

    And I logout

    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - enhance_form_status"