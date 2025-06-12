Feature: E.128.800 - The system shall support the ability to exclude fields from being monitored using Monitoring QR external module.

  As a REDCap end user
  I want to see that Monitoring QR is functioning as expected

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
    And I should NOT see "Monitoring QR - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Monitoring QR"
    And I click on the button labeled "Enable" in the dialog box
    Then I should see "Monitoring QR - v0.0.0"
 
  Scenario: Enable external module in project
    Given I create a new project named "E.128.800" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/E128700.xml", and clicking the "Create Project" button
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see "Monitoring QR - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Monitoring QR - v0.0.0"
    Then I should see "Monitoring QR - v0.0.0"

    # E.128.1100
    Given I click on the button labeled exactly "Configure"
    Then I should see "Configure Module" in the dialog box
    And I enter "_monstat" into the input field labeled "Provide the suffix used to identify the monitoring field on a form" in the dialog box
    And I enter "@ENDPOINT-\w+" into the textarea field labeled "Provide the regex used to identify fields that should be monitored" in the dialog box
    And I select "Monitor" on the dropdown field labeled "What role do monitors use?" in the dialog box
    And I select "DataEntry" on the dropdown field labeled "1. What roles do data entry users use?" in the dialog box
     And I select "DataManager" on the dropdown field labeled "What role do data managers use?" in the dialog box
    Then I enter "4" into the input field labeled "Id of monitoring status field meaning 'Not required'" in the dialog box
    And I enter "2" into the input field labeled "Id of monitoring status field meaning 'Requires verification'" in the dialog box
    And I enter "3" into the input field labeled "Id of monitoring status field meaning 'Requires verification due to data change'" in the dialog box
    And I enter "1" into the input field labeled "Id of monitoring status field meaning 'Verification complete'" in the dialog box
    And I enter "5" into the input field labeled "Id of monitoring status field meaning 'Verification in progress'" in the dialog box
    And I select "Never" on the dropdown field labeled "A form's monitoring status is automatically set to 'Requires verification due to data change'" in the dialog box
    And I scroll to the field labeled "When the user visits the Resolve Issues page, handle monitor status fields by"
    And I select "Hiding the button to interact with the query but leave the row in place" on the dropdown field labeled "When the user visits the Resolve Issues page, handle monitor status fields by" in the dialog box
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Monitoring QR - v0.0.0"

    #ACTION: Enable the Data Resolution Workflow
    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Additional customizations"
    And I select "Data Resolution Workflow" on the dropdown field labeled "Enable:"
    Then I click on the button labeled "Save"
    Then I should see "The Data Resolution Workflow has now been enabled!"
    And I click on the button labeled "Close" in the dialog box

    # Adding Test_User1 to DataEntry role and DAG1
    Given I click on the link labeled "User Rights"
    When I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataEntry" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I select "DAG1" on the dropdown field labeled "Assign To DAG" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "DataEntry" row of the column labeled "Username" of the User Rights table

    # Adding Test_User2 with 'Project Setup & Design' User Rights
    Given I enter "Test_User2" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I check the User Right named "Project Setup & Design"
    Then I should see a checkbox labeled "Monitoring QR" that is checked
    And I click on the button labeled "Add user"
    Then I should see "successfully added"

    # Adding Test_User4 to Monitor role
    When I enter "Test_User4" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "Monitor" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User4" within the "Monitor" row of the column labeled "Username" of the User Rights table

    # ACTION: Import data 
    Given I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "import_files/redcap_val/E128700_Data_Import.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I should see "Your document was uploaded successfully and is ready for review."
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
    And I logout

    Given I login to REDCap with the user "Test_User4"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.800"
    And I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the third instance
    # VERIFY -  E.128.1300
    Then I should see the field labeled "Name" disabled
    And I should see a button labeled "Save & Exit Form"
    And I should see a button labeled "Cancel"
    And I should see "Monitor query status: NONE"
    Then I should see a table header and rows containing the following values in a table:
      | Field             | Flags                            | Query to raise |
      | ptname            | @ENDPOINT-PRIMARY                |                |
      | identifier        | -- not flagged for monitoring -- |                |
      | text2             | -- not flagged for monitoring -- |                |
      | notesbox          | @ENDPOINT-PRIMARY                |                |
      | dropdown          | @ENDPOINT-SECONDARY              |                |
      | radio_button_auto | @ENDPOINT-SECONDARY              |                |
      | checkbox	        | -- not flagged for monitoring -- |                |

    When I enter "Query1" in the column "Query to raise" for the field "ptname"
    And I enter "Query2" in the column "Query to raise" for the field "text2"
    And I enter "Query3" in the column "Query to raise" for the field "notesbox"
    And I enter "Query4" in the column "Query to raise" for the field "radio_button_auto"
    And I click on the button labeled "Raise monitor query"
    Then I should see "Showing queried fields only"
    And I should see "Verification in progress"
    # VERIFY -  E.128.1400
    Then I should see a table header and rows containing the following values in a table:
      | Field             | Field value | Query response [comment] | Reply | Query  |
      | ptname            | Paul        |                          |       | Query1 |
      | text2             |             |                          |       | Query2 |
      | notesbox          |             |                          |       | Query3 |
      | radio_button_auto |             |                          |       | Query4 |

    And I should NOT see "identifier" in the monitoring table
    And I should NOT see "dropdown" in the monitoring table
    And I should NOT see "checkbox" in the monitoring table

    Given I click on the link labeled "Record Status Dashboard"
    # Readonly rights on Instrument
    When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1-1" and click on the bubble
    And I should NOT see a button labeled "Save & Exit Form"
    And I should NOT see a button labeled "Cancel"    
    And I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.800"

    # VERIFY - E.128.1100
    When I click on the link labeled "Resolve Issues"
    Then I should see "Data Resolution Dashboard"
    When I select the option "All status types (1)" from the dropdown field for Status in Data Resolution Dashboard
    Then I should see a table rows containing the following values in a table:
      | 1-1 (#3) Event 1 (Arm 1: Arm 1)   | Field: data_types_monstat (Monitoring Status)      | Test_User4 | [same as first update] |
    
    And I should NOT see a button labeled "comment"

    # E.128.800, E.128.1100, E.128.1200, E.128.1300, E.128.1400
    Given I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Configure"
    Then I should see "Configure Module" in the dialog box
    And I scroll to the field labeled "When checked, the first column in the inline table below the data entry form includes the field label after the field name"
    And I check the checkbox labeled "When checked, the first column in the inline table below the data entry form includes the field label after the field name" in the dialog box
    And I check the checkbox labeled "When checked, the default behaviour of making all fields readonly (except the monitor status and form status fields) is not applied" in the dialog box
    And I check the checkbox labeled "When checked, the save and cancel buttons are not hidden when the user is not a data entry user" in the dialog box
    And I select "Removing the entire row from the table and removing filter counts" on the dropdown field labeled "When the user visits the Resolve Issues page, handle monitor status fields by" in the dialog box
    And I enter "@NOTMONITORED" into the input field labeled "An action tag that indicates the field should not be monitored" in the dialog box
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Monitoring QR - v0.0.0"

    # VERIFY -  E.128.1100
    Given I click on the link labeled "Resolve Issues"
    Then I should see "Data Resolution Dashboard"
    When I select the option "All status types" from the dropdown field for Status in Data Resolution Dashboard
    Then I should NOT see "data_types_monstat"
    And I should NOT see "Monitoring Status"
    And I logout

    Given I login to REDCap with the user "Test_User4"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.800"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the third instance
    And I should see a button labeled "Save & Exit Form"
    And I should see a button labeled "Cancel"
    # VERIFY -  E.128.1400
    Then I should see a table header and rows containing the following values in a table:
      | Field                                 | Field value | Query response [comment] | Reply | Query  |
      | ptname [Name]                         | Paul        |                          |       | Query1 |
      | text2 [Text2]                         |             |                          |       | Query2 |
      | notesbox [Notes Box]                  |             |                          |       | Query3 |
      | radio_button_auto [Radio Button Auto] |             |                          |       | Query4 |

    #VERIFY - E.128.1300
    And I clear field and enter "Name1" into the data entry form field labeled "Name"
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument

    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the first instance
    Then I should see a table header and rows containing the following values in a table:
      | Field             | Flags                            | Query to raise |
      | ptname            | @ENDPOINT-PRIMARY                |                |
      | text2             | -- not flagged for monitoring -- |                |
      | notesbox          | @ENDPOINT-PRIMARY                |                |
      | dropdown          | @ENDPOINT-SECONDARY              |                |
      | radio_button_auto | @ENDPOINT-SECONDARY              |                |
      | checkbox	        | -- not flagged for monitoring -- |                |

    # VERIFY -  E.128.800
    And I should NOT see "identifier" in the monitoring table

    # VERIFY -  E.128.1200
    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1-1" and click on the bubble
    And I should NOT see a button labeled "Save & Exit Form"
    And I should see a button labeled "Cancel" disabled
    And I logout

    #VERIFY - E.128.1600 - Only Super-users can configure external Module
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.800"
    And I click on the link labeled exactly "Manage"
    Then I should see "Monitoring QR - v0.0.0"
    And I should NOT see the button labeled "Disable"
    When I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    And I should NOT see "Hide this module from non-admins in the list of enabled modules on this project" in the dialog box
    And I should NOT see "Provide the suffix used to identify the monitoring field on a form" in the dialog box
    And I should NOT see "Provide the regex used to identify fields that should be monitored" in the dialog box
    And I should NOT see "What role do monitors use" in the dialog box
    And I should NOT see "What roles do data entry users use" in the dialog box
    And I should NOT see "What role do data managers use" in the dialog box
    And I should NOT see "Id of monitoring status field meaning" in the dialog box
    And I should NOT see "A form's monitoring status is automatically set to 'Requires verification" in the dialog box
    And I should NOT see "An action tag that indicates the field should not be monitored" in the dialog box
    And I should NOT see "If the user has the monitor role, when checked, any open queries will be shown inline with the question being queried" in the dialog box
    And I should NOT see "If the user has the data entry role, when checked, any open queries will be shown inline with the question being queried" in the dialog box
    And I should NOT see "If the user has the data manager role, when checked, any open queries will be shown inline with the question being queried" in the dialog box
    And I should NOT see "Monitors can only raise queries against flagged fields" in the dialog box
    And I should NOT see "When the user visits the Resolve Issues page, handle monitor status fields by" in the dialog box
    And I should NOT see "When checked, the save and cancel buttons are not hidden when the user is not a data entry user" in the dialog box
    And I should NOT see "When checked, the default behaviour of making all fields readonly (except the monitor status and form status fields) is not applied" in the dialog box
    And I should NOT see "When checked, the first column in the inline table below the data entry form includes the field label after the field name" in the dialog box
    And I click on the button labeled "Cancel" in the dialog box
    Then I should see "Monitoring QR - v0.0.0"
    And I logout

  Scenario: E.128.100 - Disable external module
    # Disable external module in project
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.800"
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Monitoring QR - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Monitoring QR - v0.0.0"

    Given I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
      | Time / Date      | Username   | Action                                                                      | List of Data Changes OR Fields Exported                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "monitoring_qr_v0.0.0" for project                  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "monitoring_qr_v0.0.0" for project | ignore-for-monitoring-action-tag, resolve-issues-behaviour, do-not-hide-save-and-cancel-buttons-for-non-data-entry, do-not-make-fields-readonly, include-field-label-in-inline-form                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "monitoring_qr_v0.0.0" for project | reserved-hide-from-non-admins-in-project-list, monitoring-field-suffix, monitoring-flags-regex, monitoring-role, data-entry-roles, data-manager-role, monitoring-not-required-key, monitoring-requires-verification-key, monitoring-requires-verification-due-to-data-change-key, monitoring-field-verified-key, monitoring-verification-in-progress-key, trigger-requires-verification-for-change, monitoring-role-show-inline, data-entry-role-show-inline, data-manager-role-show-inline, monitors-only-query-flagged-fields, resolve-issues-behaviour, do-not-hide-save-and-cancel-buttons-for-non-data-entry, do-not-make-fields-readonly, include-field-label-in-inline-form |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "monitoring_qr_v0.0.0" for project                   |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    Then I should see "Monitoring QR - v0.0.0"
    When I click on the button labeled "View Usage"
    Then I should see "None" in the dialog box
    And I should NOT see "E.128.800" in the dialog box
    And I close the dialog box for the external module "Monitoring QR"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Monitoring QR - v0.0.0"

    Given I click on the link labeled "User Activity Log"
    Then I should see a table header and row containing the following values in a table:
      | Time             | User       | Event                                                                       |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "monitoring_qr_v0.0.0" for system                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "monitoring_qr_v0.0.0" for project                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "monitoring_qr_v0.0.0" for project |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "monitoring_qr_v0.0.0" for project                   |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "monitoring_qr_v0.0.0" for system                    |

    And I logout

    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - monitoring_qr"