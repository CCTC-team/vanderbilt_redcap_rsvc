Feature: E.128.700 - The system shall support the ability to set up Monitoring QR module in projects.

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
    Given I create a new project named "E.128.700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/E128700.xml", and clicking the "Create Project" button
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see "Monitoring QR - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Monitoring QR - v0.0.0"
    Then I should see "Monitoring QR - v0.0.0"

    #ACTION: Enable the Data Resolution Workflow
    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Additional customizations"
    And I select "Data Resolution Workflow" on the dropdown field labeled "Enable:"
    Then I click on the button labeled "Save"
    Then I should see "The Data Resolution Workflow has now been enabled!"
    And I click on the button labeled "Close" in the dialog box

    # Adding Test_User1 to DataEntryPI role and DAG1
    Given I click on the link labeled "User Rights"
    When I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataEntryPI" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I select "DAG1" on the dropdown field labeled "Assign To DAG" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "DataEntryPI" row of the column labeled "Username" of the User Rights table

    # Adding Test_User2 to DataEntry role and DAG2
    When I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataEntry" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I select "DAG2" on the dropdown field labeled "Assign To DAG" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User2" within the "DataEntry" row of the column labeled "Username" of the User Rights table

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

    # E.128.800, E.128.900
    And I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Configure"
    Then I should see "Configure Module" in the dialog box
    And I enter "_monstat" into the input field labeled "Provide the suffix used to identify the monitoring field on a form" in the dialog box
    And I enter "@ENDPOINT-\w+" into the textarea field labeled "Provide the regex used to identify fields that should be monitored" in the dialog box
    And I select "Monitor" on the dropdown field labeled "What role do monitors use?" in the dialog box
    And I select "DataEntry" on the dropdown field labeled "1. What roles do data entry users use?" in the dialog box
    And I click on the button labeled "+" for the field labeled "1. What roles do data entry users use?" in the external module configuration
    And I select "DataEntryPI" on the dropdown field labeled "2. What roles do data entry users use?" in the dialog box
    And I select "DataManager" on the dropdown field labeled "What role do data managers use?" in the dialog box
    Then I enter "4" into the input field labeled "Id of monitoring status field meaning 'Not required'" in the dialog box
    And I enter "2" into the input field labeled "Id of monitoring status field meaning 'Requires verification'" in the dialog box
    And I enter "3" into the input field labeled "Id of monitoring status field meaning 'Requires verification due to data change'" in the dialog box
    And I enter "1" into the input field labeled "Id of monitoring status field meaning 'Verification complete'" in the dialog box
    And I enter "5" into the input field labeled "Id of monitoring status field meaning 'Verification in progress'" in the dialog box
    And I select "Always whenever any field is updated" on the dropdown field labeled "A form's monitoring status is automatically set to 'Requires verification due to data change'" in the dialog box
    And I scroll to the field labeled "When the user visits the Resolve Issues page, handle monitor status fields by"
    And I select "Hiding the button to interact with the query but leave the row in place" on the dropdown field labeled "When the user visits the Resolve Issues page, handle monitor status fields by" in the dialog box
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Monitoring QR - v0.0.0"
    And I logout

    # E.128.1700, E.128.1800 - Repeating Instruments Arm 1
    Given I login to REDCap with the user "Test_User4"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.700"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    # View and Edit Rights on Instrument
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the third instance
    Then I enter "Query1" in the column "Query to raise" for the field "ptname"
    When I click on the button labeled "Raise monitor query"
    Then I should see the monitoring status "Verification in progress"

    Given I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1-1" and click the repeating instrument bubble for the second instance
    Then I enter "Query2" in the column "Query to raise" for the field "checkbox"
    And I click on the button labeled "Raise monitor query"
    Then I should see the monitoring status "Verification in progress"

    # E.128.1700, E.128.1800 - Repeating Events Arm 2
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the tab labeled "Arm Two"
    And I click on the link labeled exactly "2-1"
    When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "(#2)"
    Then I should see "(Instance #2)"
    And I enter "Query3" in the column "Query to raise" for the field "text2"
    When I click on the button labeled "Raise monitor query"
    Then I should see the monitoring status "Verification in progress"

    And I click on the link labeled exactly "2-1"
    When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "(#1)"
    And I enter "Query4" in the column "Query to raise" for the field "dropdown"
    When I click on the button labeled "Raise monitor query"
    Then I should see the monitoring status "Verification in progress"

    # Non Repeating Instrument
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the tab labeled "Arm 1"
    # Readonly rights on Instrument
    When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1-1" and click on the bubble
    And I enter "Query5" in the column "Query to raise" for the field "ptname_v2"
    When I click on the button labeled "Raise monitor query"
    Then I should see the monitoring status "Verification in progress"

    Given I click on the link labeled "Monitoring QR"
    Then I should see a table header and rows containing the following values in a table:
      | Timestamp	       | Query status | Monitor status           | Record | Form            | Event name [event id] | Instance | Field [label]                       | Flags               | Query  | Response [comment] |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | text_validation | Event 1 [40]	        | 1        | ptname_v2 [Name]                    | unflagged           | Query5 |                    |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 2-1	  | data_types      | Event 1 [43]	        | 1        | dropdown [Multiple Choice Dropdown] | @ENDPOINT-SECONDARY | Query4 |                    |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 2-1	  | data_types      | Event 1 [43]	        | 2        | text2 [Text2]                       | unflagged       	   | Query3 |                    |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | data_types      | Event 1 [40]	        | 2        | checkbox [Checkbox]	               | unflagged           | Query2 |                    |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | data_types      | Event 1 [40]	        | 3        | ptname [Name]                       | @ENDPOINT-PRIMARY   | Query1 |                    |

    And I should see 5 rows in the monitoring logging table
    When I click on the "third" view icon
    Then I should see "2-1"
    And I should see "Data Types"
    And I should see "Event 1 (Arm 2: Arm Two)"
    And I should see "Instance #2"

    Given I click on the link labeled "Monitoring QR"
    And I click on the "first" view icon
    Then I should see "1-1"
    And I should see "Text Validation"
    And I should see "Event 1 (Arm 1: Arm 1)"

    # Filter by form
    Given I click on the link labeled "Monitoring QR"
    When I select "text_validation" on the dropdown field labeled "Form"
    Then I should see a table header and rows containing the following values in a table:
      | Timestamp	       | Query status | Monitor status           | Record | Form            | Event name [event id] | Instance | Field [label]                       | Flags               | Query  | Response [comment] |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | text_validation | Event 1 [40]	        | 1        | ptname_v2 [Name]                    | unflagged           | Query5 |                    |
    
    And I should see 1 row in the monitoring logging table
    And I should NOT see "data_types"

    # Filter by event
    When I select "any form" on the dropdown field labeled "Form"
    When I select "Event 1 [40]" on the dropdown field labeled "Event"
    Then I should see a table header and rows containing the following values in a table:
      | Timestamp	       | Query status | Monitor status           | Record | Form            | Event name [event id] | Instance | Field [label]                       | Flags               | Query  | Response [comment] |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | text_validation | Event 1 [40]	        | 1        | ptname_v2 [Name]                    | unflagged           | Query5 |                    |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | data_types      | Event 1 [40]	        | 2        | checkbox [Checkbox]	               | unflagged           | Query2 |                    |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | data_types      | Event 1 [40]	        | 3        | ptname [Name]                       | @ENDPOINT-PRIMARY   | Query1 |                    |

    And I should see 3 rows in the monitoring logging table
    And I should NOT see "Event 1 [43]"

    # Filter by event and flag
    When I select "@ENDPOINT-PRIMARY" on the dropdown field labeled "Flag"
    Then I should see a table header and rows containing the following values in a table:
      | Timestamp	       | Query status | Monitor status           | Record | Form            | Event name [event id] | Instance | Field [label]                       | Flags               | Query  | Response [comment] |
       | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | data_types      | Event 1 [40]	        | 3        | ptname [Name]                       | @ENDPOINT-PRIMARY   | Query1 |                    |

    And I should see 1 row in the monitoring logging table
    And I should NOT see "Event 1 [43]"
    And I should NOT see "unflagged"
    And I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.700"
    When I click on the link labeled "Monitoring QR"
    Then I should see "Use this page to review the monitoring queries for your project. The options below can be used to filter the queries as required."
    Then I should see a table header and rows containing the following values in a table:
      | Timestamp	       | Query status | Monitor status           | Record | Form            | Event name [event id] | Instance | Field [label]                       | Flags               | Query  | Response [comment] |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | text_validation | Event 1 [40]	        | 1        | ptname_v2 [Name]                    | unflagged           | Query5 |                    |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | data_types      | Event 1 [40]	        | 2        | checkbox [Checkbox]	               | unflagged           | Query2 |                    |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | data_types      | Event 1 [40]	        | 3        | ptname [Name]                       | @ENDPOINT-PRIMARY   | Query1 |                    |

    # DAG access verified
    And I should NOT see "2-1"
    And I should see 3 rows in the monitoring logging table

    # Filter by instance
    When I select "2" on the dropdown field labeled "Instance"
    Then I should see a table header and rows containing the following values in a table:
      | Timestamp	       | Query status | Monitor status           | Record | Form            | Event name [event id] | Instance | Field [label]                       | Flags               | Query  | Response [comment] |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 1-1	  | data_types      | Event 1 [40]	        | 2        | checkbox [Checkbox]	               | unflagged           | Query2 |                    |

    And I should see 1 row in the monitoring logging table
    And I logout

    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.700"
    When I click on the link labeled "Monitoring QR"
    Then I should see "Use this page to review the monitoring queries for your project. The options below can be used to filter the queries as required."
    Then I should see a table header and rows containing the following values in a table:
      | Timestamp	       | Query status | Monitor status           | Record | Form            | Event name [event id] | Instance | Field [label]                       | Flags               | Query  | Response [comment] |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 2-1	  | data_types      | Event 1 [43]	        | 1        | dropdown [Multiple Choice Dropdown] | @ENDPOINT-SECONDARY | Query4 |                    |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 2-1	  | data_types      | Event 1 [43]	        | 2        | text2 [Text2]                       | unflagged       	   | Query3 |                    |

    # DAG access verified
    And I should NOT see "1-1"
    And I should see 2 rows in the monitoring logging table

    # Filter by field
    When I select "text2" on the dropdown field labeled "Field"
    Then I should see a table header and rows containing the following values in a table:
      | Timestamp	       | Query status | Monitor status           | Record | Form            | Event name [event id] | Instance | Field [label]                       | Flags               | Query  | Response [comment] |
      | mm/dd/yyyy hh:mm | OPEN         | Verification in progress | 2-1	  | data_types      | Event 1 [43]	        | 2        | text2 [Text2]                       | unflagged       	   | Query3 |                    |

    And I should see 1 row in the monitoring logging table
    And I logout   

  Scenario: E.128.100 - Disable external module
    # Disable external module in project
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.128.700"
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
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "monitoring_qr_v0.0.0" for project | reserved-hide-from-non-admins-in-project-list, monitoring-field-suffix, monitoring-flags-regex, monitoring-role, data-entry-roles, data-manager-role, monitoring-not-required-key, monitoring-requires-verification-key, monitoring-requires-verification-due-to-data-change-key, monitoring-field-verified-key, monitoring-verification-in-progress-key, trigger-requires-verification-for-change, monitoring-role-show-inline, data-entry-role-show-inline, data-manager-role-show-inline, monitors-only-query-flagged-fields, resolve-issues-behaviour, do-not-hide-save-and-cancel-buttons-for-non-data-entry, do-not-make-fields-readonly, include-field-label-in-inline-form |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "monitoring_qr_v0.0.0" for project                   |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    Then I should see "Monitoring QR - v0.0.0"
    When I click on the button labeled "View Usage"
    Then I should see "None" in the dialog box
    And I should NOT see "E.128.700" in the dialog box
    And I close the dialog box for the external module "Monitoring QR"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Monitoring QR - v0.0.0"

    # Not checking 'Delete Version' for now as this is used for deleting lower versions.
    # If the entire EM is deleted REDCap throws an error

    Given I click on the link labeled "User Activity Log"
    Then I should see a table header and row containing the following values in a table:
      | Time             | User       | Event                                                                             |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "monitoring_qr_v0.0.0" for system                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "monitoring_qr_v0.0.0" for project                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "monitoring_qr_v0.0.0" for project |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "monitoring_qr_v0.0.0" for project                   |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "monitoring_qr_v0.0.0" for system                    |

    And I logout
    
    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - monitoring_qr"