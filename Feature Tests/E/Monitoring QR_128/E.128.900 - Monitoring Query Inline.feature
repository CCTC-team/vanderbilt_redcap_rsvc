Feature: E.128.900 - The system shall allow users to view monitoring queries inline with the question based on their roles using Monitoring QR external module.

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
    Given I create a new project named "E.128.900" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/E128700.xml", and clicking the "Create Project" button
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see "Monitoring QR - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Monitoring QR - v0.0.0"
    Then I should see "Monitoring QR - v0.0.0"

    # E.128.900
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
    And I check the checkbox labeled "If the user has the monitor role, when checked, any open queries will be shown inline with the question being queried" in the dialog box
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

    # Adding Test_User3 to DataManager role
    When I enter "Test_User3" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataManager" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User3" within the "DataManager" row of the column labeled "Username" of the User Rights table

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
    And I click on the link labeled "E.128.900"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    # View and Edit Rights on Instrument
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the third instance
    And I should see "This form has never had a monitor query raised. You can raise queries against any fields using the form below. Ignored fields are not shown."
    And I should see "Monitor query status: NONE"
    And I should see a table header and rows containing the following values in a table:
      | Field             | Flags                            | Query to raise |
      | ptname            | @ENDPOINT-PRIMARY                |                |
      | identifier        | -- not flagged for monitoring -- |                |
      | text2             | -- not flagged for monitoring -- |                |
      | notesbox          | @ENDPOINT-PRIMARY                |                |
      | dropdown          | @ENDPOINT-SECONDARY              |                |
      | radio_button_auto | @ENDPOINT-SECONDARY              |                |
      | checkbox	        | -- not flagged for monitoring -- |                |

    Then I enter "Query1" in the column "Query to raise" for the field "ptname"
    When I click on the button labeled "Raise monitor query"
    # VERIFY - E.128.900
    And I should see "Query1" within the data entry field labeled "Name"
    And I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.900"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the third instance
    Then I should see "Showing queried fields only. Waiting for responses."
    # VERIFY - E.128.900
    And I should NOT see "Query1" within the data entry field labeled "Name"
    And I logout

    Given I login to REDCap with the user "Test_User3"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.900"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the third instance
    Then I should see "Showing queried fields only. Waiting for responses."
    # VERIFY - E.128.900
    And I should NOT see "Query1" within the data entry field labeled "Name"
    And I logout

    # E.128.900, E.128.1000
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.900"
    And I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Configure"
    Then I should see "Configure Module" in the dialog box
    And I scroll to the field labeled "Monitors can only raise queries against flagged fields"
    And I check the checkbox labeled "Monitors can only raise queries against flagged fields"
    And I check the checkbox labeled "If the user has the data manager role, when checked, any open queries will be shown inline with the question being queried" in the dialog box
    And I check the checkbox labeled "If the user has the data entry role, when checked, any open queries will be shown inline with the question being queried" in the dialog box
    And I uncheck the checkbox labeled "If the user has the monitor role, when checked, any open queries will be shown inline with the question being queried" in the dialog box
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Monitoring QR - v0.0.0"
    And I logout

    Given I login to REDCap with the user "Test_User4"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.900"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the third instance
    Then I should see "Showing queried fields only"
    # VERIFY - E.128.900
    And I should NOT see "Query1" within the data entry field labeled "Name"

    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the first instance
    # VERIFY - E.128.1000
    And I should see a table header and rows containing the following values in a table:
      | Field             | Flags                            | Query to raise |
      | ptname            | @ENDPOINT-PRIMARY                |                |
      | notesbox          | @ENDPOINT-PRIMARY                |                |
      | dropdown          | @ENDPOINT-SECONDARY              |                |
      | radio_button_auto | @ENDPOINT-SECONDARY              |                |

    And I should NOT see "identifier" in the monitoring table
    And I should NOT see "text2" in the monitoring table
    And I should NOT see "checkbox" in the monitoring table
    And I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.900"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the third instance
    Then I should see "Showing queried fields only. Waiting for responses."
    # VERIFY - E.128.900
    And I should see "Query1" within the data entry field labeled "Name"
    And I logout

    Given I login to REDCap with the user "Test_User3"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.900"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the third instance
    Then I should see "Showing queried fields only. Waiting for responses."
    # VERIFY - E.128.900
    And I should see "Query1" within the data entry field labeled "Name"
    And I logout

  Scenario: E.128.100 - Disable external module
    # Disable external module in project
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.900"
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
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "monitoring_qr_v0.0.0" for project | monitoring-role-show-inline, data-entry-role-show-inline, data-manager-role-show-inline, monitors-only-query-flagged-fields                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "monitoring_qr_v0.0.0" for project | reserved-hide-from-non-admins-in-project-list, monitoring-field-suffix, monitoring-flags-regex, monitoring-role, data-entry-roles, data-manager-role, monitoring-not-required-key, monitoring-requires-verification-key, monitoring-requires-verification-due-to-data-change-key, monitoring-field-verified-key, monitoring-verification-in-progress-key, trigger-requires-verification-for-change, monitoring-role-show-inline, data-entry-role-show-inline, data-manager-role-show-inline, monitors-only-query-flagged-fields, resolve-issues-behaviour, do-not-hide-save-and-cancel-buttons-for-non-data-entry, do-not-make-fields-readonly, include-field-label-in-inline-form |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "monitoring_qr_v0.0.0" for project                   |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    Then I should see "Monitoring QR - v0.0.0"
    When I click on the button labeled "View Usage"
    Then I should see "None" in the dialog box
    And I should NOT see "E.128.900" in the dialog box
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