Feature: E.127.700 - The system shall support the ability to set up and view logs using Data Entry Log module.
  
  As a REDCap end user
  I want to see that Data Entry Log External Module work as expected

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
    And I should NOT see "Data Entry Log - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Data Entry Log"
    And I click on the button labeled "Enable" in the dialog box
    Then I should see "Data Entry Log - v0.0.0"
 
  Scenario: Enable external module in project
    Given I create a new project named "E.127.700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_nodata.xml", and clicking the "Create Project" button
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Data Entry Log - v0.0.0"
    Then I should see "Data Entry Log - v0.0.0"

    # Add User Test_User1 with 'Project Setup & Design' rights
    Given I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named "Project Setup & Design"
    And I check the User Right named "Logging"
    Then I should see a checkbox labeled "Data Entry Log" that is checked
    And I click on the button labeled "Add user"
    Then I should see "successfully added"

    # Add User Test_User2
    Given I click on the link labeled "User Rights"
    And I enter "Test_User2" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named "Logging"
    And I click on the button labeled "Add user"
    Then I should see "successfully added"
     
    # Assign Test_User1 to DAG1
    Given I click on the link labeled "DAGs"
    When I select "test_user1 (Test User1)" on the dropdown field labeled "Assign user"
    And I select "DAG1" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"

    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups | Users in group          |
      | DAG1               | test_user1 (Test User1) |

    # Assign Test_User2 to DAG2
    Given I click on the link labeled "DAGs"
    When I select "test_user2 (Test User2)" on the dropdown field labeled "Assign user"
    And I select "DAG2" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"

    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups | Users in group          |
      | DAG1               | test_user1 (Test User1) |
      | DAG2               | test_user2 (Test User2) |

    And I logout

  Scenario: E.127.1200, E.127.1300 - Data Entry Log for Repeating Instruments in Arm 1
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.127.700"
    Then I should see "Project Home and Design"
    When I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    # E.127.1100 - Only Super-admins can configure external Module in project
    And I should NOT see the button labeled "Disable"
    And I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    And I should NOT see "Hide this module from non-admins in the list of enabled modules on this project" in the dialog box
    And I should NOT see "The maximum number of days permitted when not limiting the records being queried. Limit to improve performance" in the dialog box
    And I should NOT see "When given, any fields matching the given regex will always be excluded from the list of data entry logs" in the dialog box
    And I should NOT see "If checked, event names are suffixed with the event ID" in the dialog box
    And I should NOT see "If checked, arm names are suffixed with the arm ID" in the dialog box
    And I should NOT see "If checked, DAG names are suffixed with the DAG ID" in the dialog box
    Then I click on the button labeled "Cancel" in the dialog box

    When I click on the link labeled "Data Entry Log"
    Then I should see "No log entries found"

    Given I click on the link labeled "Add / Edit Records"
    When I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 2"
    Then I enter "1" into the data entry form field labeled "CRF Versioning"
    Then I enter "testuser1@abc.com" into the data entry form field labeled "Email"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    When I click on the link labeled "Data Entry Log"
    Then I should see a table header and rows containing the following values in the a table:
      |  Date / Time      | Username   | Record ID | Group | Arm   | Instance | Form            | Field and Label                         | New Value         | Action        |
      |  mm/dd/yyyy hh:mm | test_user1 | 1-1       | DAG1  | Arm 1 |          | text_validation | text_validation_crfver [CRF Versioning] | 1                 | Create record |
      |  mm/dd/yyyy hh:mm | test_user1 | 1-1       | DAG1  | Arm 1 |          | text_validation | email_v2 [Email]	                      | testuser1@abc.com	| Create record |
      |  mm/dd/yyyy hh:mm | test_user1 | 1-1       | DAG1  | Arm 1 |          | text_validation | text_validation_complete [Complete?]    | 0                 | Create record |

    And I should see 3 rows in the data entry log table

    # Repeating Instruments - Instance 1
    Given I click on the link labeled "Add / Edit Records"
    When I click on the button labeled "Add new record for the arm selected above"
    And I click on the link labeled "1-2"
    When I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I select "Choice1" on the radio field labeled "Radio Button Auto"
    Then I select "Complete" on the dropdown field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    # Repeating Instruments - Instance 2
    Given I click on the button labeled "Add new"
    Then I should see "Editing existing Record ID 1-2"
    And I should see "Data Types"
    And I should see "(Instance #2)"
    And I check the checkbox labeled "Checkbox"
    And I check the checkbox labeled "Checkbox2"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    # Repeating Instruments - Instance 3
    Given I click on the button labeled "Add new"
    Then I should see "Editing existing Record ID 1-2"
    And I should see "Data Types"
    And I should see "(Instance #3)"
    Then I enter "Notes" into the data entry form field labeled "Note Box"
    And I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/redcap_val/file1.csv", by clicking the button near "Select a file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    When I click on the link labeled "Data Entry Log"
    Then I should see a table header and rows containing the following values in the a table:
      | Username   | Record ID | Group | Event   | Arm   | Instance | Form            | Field and Label                                        | New Value         | Action        |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 3        | data_types	    | data_types_crfver [CRF Versioning]                     | 1                 | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 3        | data_types	    | ptname [Name]	                                         | Test User1        | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 3        | data_types	    | notesbox [Notes Box]	                                 | Notes             | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 3        | data_types	    | file_upload [File Upload]                              | 2                 | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 3        | data_types	    | data_types_complete [Complete?]	                       | 0                 | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 2        | data_types	    | data_types_crfver [CRF Versioning]                     | 1                 | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 2        | data_types	    | ptname [Name]	                                         | Test User1        | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 2        | data_types	    | checkbox [Checkbox]            	                       | item[1] checked   | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 2        | data_types	    | checkbox [Checkbox]           	                       | item[2] checked   | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 | 2        | data_types	    | data_types_complete [Complete?]	                       | 0                 | Update record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 |          | data_types	    | data_types_crfver [CRF Versioning]                     | 1                 | Create record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 |          | data_types	    | ptname [Name]	                                         | Test User1        | Create record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 |          | data_types	    | radio_button_auto [Radio Button Auto]                  | 1                 | Create record |
      | test_user1 | 1-2       | DAG1  | Event 1 | Arm 1 |          | data_types	    | data_types_complete [Complete?]	                       | 2                 | Create record |
      | test_user1 | 1-1       | DAG1  | Event 2 | Arm 1 |          | text_validation | text_validation_crfver [CRF Versioning]                | 1                 | Create record |
      | test_user1 | 1-1       | DAG1  | Event 2 | Arm 1 |          | text_validation | email_v2 [Email]	                                     | testuser1@abc.com | Create record |
      | test_user1 | 1-1       | DAG1  | Event 2 | Arm 1 |          | text_validation | text_validation_complete [Complete?]                   | 0                 | Create record |

    And I should see 17 rows in the data entry log table

    # Download
    Given I select "Event 1 [40]" on the dropdown field labeled "Event"
    And I select "10" on the dropdown field labeled "Page size"
    When I click on the button labeled "Export current page"
    Then the downloaded CSV with filename "E127700_DataEntryLog_yyyy-mm-dd_hhmm.csv" has the header and rows below
      | user name  | record | group id | group name |event id    | event name | arm number | arm name | instance | form name       | field                    | field label       | value             | reason for change | action        |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types      | data_types_crfver        | CRF Versioning    | 1                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | ptname                   | Name              | Test User1        |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | notesbox                 | Notes Box         | Notes             |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | file_upload              | File Upload       | 2                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | data_types_complete      | Complete?         | 0                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | data_types_crfver        | CRF Versioning    | 1                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | ptname                   | Name              | Test User1        |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | checkbox                 | Checkbox          | item[1] checked   |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | checkbox                 | Checkbox          | item[2] checked   |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | data_types_complete      | Complete?         | 0                 |                   | Update record |

    When I click on the button labeled "Export all pages"
    Then the downloaded CSV with filename "E127700_DataEntryLog_yyyy-mm-dd_hhmm.csv" has the header and rows below
      | user name  | record | group id | group name |event id    | event name | arm number | arm name | instance | form name       | field                    | field label       | value             | reason for change | action        |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types      | data_types_crfver        | CRF Versioning    | 1                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | ptname                   | Name              | Test User1        |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | notesbox                 | Notes Box         | Notes             |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | file_upload              | File Upload       | 2                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | data_types_complete      | Complete?         | 0                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | data_types_crfver        | CRF Versioning    | 1                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | ptname                   | Name              | Test User1        |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | checkbox                 | Checkbox          | item[1] checked   |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | checkbox                 | Checkbox          | item[2] checked   |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | data_types_complete      | Complete?         | 0                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    |          | data_types	     | data_types_crfver        | CRF Versioning    | 1                 |                   | Create record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    |          | data_types	     | ptname                   | Name              | Test User1        |                   | Create record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    |          | data_types	     | radio_button_auto        | Radio Button Auto | 1                 |                   | Create record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    |          | data_types	     | data_types_complete      | Complete?         | 2                 |                   | Create record |

    When I click on the button labeled "Export everything ignoring filters"
    Then the downloaded CSV with filename "E127700_DataEntryLog_yyyy-mm-dd_hhmm.csv" has the header and rows below
      | user name  | record | group id | group name |event id    | event name | arm number | arm name | instance | form name       | field                    | field label       | value             | reason for change | action        |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types      | data_types_crfver        | CRF Versioning    | 1                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | ptname                   | Name              | Test User1        |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | notesbox                 | Notes Box         | Notes             |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | file_upload              | File Upload       | 2                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 3        | data_types	     | data_types_complete      | Complete?         | 0                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | data_types_crfver        | CRF Versioning    | 1                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | ptname                   | Name              | Test User1        |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | checkbox                 | Checkbox          | item[1] checked   |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | checkbox                 | Checkbox          | item[2] checked   |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    | 2        | data_types	     | data_types_complete      | Complete?         | 0                 |                   | Update record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    |          | data_types	     | data_types_crfver        | CRF Versioning    | 1                 |                   | Create record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    |          | data_types	     | ptname                   | Name              | Test User1        |                   | Create record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    |          | data_types	     | radio_button_auto        | Radio Button Auto | 1                 |                   | Create record |
      | test_user1 | 1-2    | 1        | DAG1       | 40         | Event 1    |            | Arm 1    |          | data_types	     | data_types_complete      | Complete?         | 2                 |                   | Create record |
      | test_user1 | 1-1    | 1        | DAG1       | 41         | Event 2    |            | Arm 1    |          | text_validation | text_validation_crfver   | CRF Versioning    | 1                 |                   | Create record |
      | test_user1 | 1-1    | 1        | DAG1       | 41         | Event 2    |            | Arm 1    |          | text_validation | email_v2                 | Email             | testuser1@abc.com |                   |  Create record |
      | test_user1 | 1-1    | 1        | DAG1       | 41         | Event 2    |            | Arm 1    |          | text_validation | text_validation_complete | Complete?         | 0                 |                   | Create record |

    # Filter by form
    Given I select "Any event" on the dropdown field labeled "Event"
    And I select "25" on the dropdown field labeled "Page size"
    When I select "text_validation" on the dropdown field labeled "Form"
    Then I should see a table header and rows containing the following values in the a table:
      | Username   | Record ID | Group | Event   | Arm   | Instance | Form            | Field and Label                         | New Value         | Action        |
      | test_user1 | 1-1       | DAG1  | Event 2 | Arm 1 |          | text_validation | text_validation_crfver [CRF Versioning] | 1                 | Create record |
      | test_user1 | 1-1       | DAG1  | Event 2 | Arm 1 |          | text_validation | email_v2 [Email]	                      | testuser1@abc.com | Create record |
      | test_user1 | 1-1       | DAG1  | Event 2 | Arm 1 |          | text_validation | text_validation_complete [Complete?]    | 0                 | Create record |
   
    And I should see 3 rows in the data entry log table
    And I should NOT see "data_types"

    # Filter by form and field
    When I enter "Email" into the input field labeled "Field name / Label"
    And I click on the button labeled "Custom range"
    Then I should see a table header and rows containing the following values in the a table:
      | Username   | Record ID | Group | Event   | Arm   | Instance | Form            | Field and Label   | New Value         | Action        |
      | test_user1 | 1-1       | DAG1  | Event 2 | Arm 1 |          | text_validation | email_v2 [Email]  | testuser1@abc.com | Create record |

    And I should see 1 row in the data entry log table
    And I should NOT see "text_validation_crfver"
    And I should NOT see "text_validation_complete"
    And I should NOT see "data_types"

    When I click on the button labeled "Past year"
    Then I should see "The request was not run - choose all records and max window of 31 days or choose a record and any time window"
    And I should see "No log entries found"
    And I logout

  Scenario: E.127.1200, E.127.1300 - Data Entry Log for Repeating Events in Arm 2
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.127.700"
    # Repeating Events - Instance 1
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the tab labeled "Arm 2"
    And I click on the button labeled "Add new record for this arm"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 2-1"
    And I should see "Data Types"
    When I clear field and enter "User 2" into the data entry form field labeled "Name"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    # Repeating Events - Instance 2
    Given I click on the button labeled "Add new"
    When I click the bubble to add a record for the "Data Types" longitudinal instrument on event "(#2)"
    Then I should see "Editing existing Record ID 2-1"
    And I should see "Data Types"
    And I should see "(Instance #2)"
    When I select "Choice99" on the radio field labeled "Radio Button Manual"
    And I enter "2001" into the data entry form field labeled "Required"
    Then I click on the button labeled "Save & Exit Form"

    When I click on the link labeled "Data Entry Log"
    Then I should see a table header and rows containing the following values in the a table:
      | Username   | Record ID | Group | Event   | Arm     | Instance | Form       | Field and Label                           | New Value       | Action        |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two | 2        | data_types | data_types_crfver [CRF Versioning]        | 1               | Update record |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two | 2        | data_types | ptname [Name]	                           | Test User1      | Update record |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two | 2        | data_types | data_types_complete [Complete?]	         | 0               | Update record |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two | 2        | data_types | radio_button_manual [Radio Button Manual] | 9..9            | Update record |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two | 2        | data_types | required [Required]                       | 2001            | Update record |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two |          | data_types | data_types_complete [Complete?]	         | 1               | Create record |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two |          | data_types | ptname [Name]                             | User 2          | Create record |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two |          | data_types | data_types_complete [Complete?]	         | 0               | Create record |

    And I should see 8 rows in the data entry log table
    And I should NOT see "test_user1"
    And I should NOT see "DAG1 [1]"
    And I should NOT see a link labeled exactly "Manage"

    When I select "Create record" on the dropdown field labeled "Action"
    Then I should see a table header and rows containing the following values in the a table:
      | Username   | Record ID | Group | Event   | Arm     | Instance | Form       | Field and Label                           | New Value       | Action        |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two |          | data_types | data_types_complete [Complete?]	         | 1               | Create record |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two |          | data_types | ptname [Name]                             | User 2          | Create record |
      | test_user2 | 2-1       | DAG2  | Event 1 | Arm Two |          | data_types | data_types_complete [Complete?]	         | 0               | Create record |

    And I should see 3 rows in the data entry log table
    And I should NOT see "Update record"
    And I logout

    #E.127.1100 - Only Super-admins can configure external Module in project
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.127.700"
    When I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I click on the button labeled "Configure"
    # E.127.800, E.127.900,E.127.1000
    Then I should see "Configure Module"
    When I enter "10" into the input field labeled "The maximum number of days permitted when not limiting the records being queried"
    And I enter "Complete?" into the textarea field labeled "When given, any fields matching the given regex will always be excluded from the list of data entry logs"
    And I check the checkbox labeled "If checked, event names are suffixed with the event ID"
    And I check the checkbox labeled "If checked, arm names are suffixed with the arm ID"
    And I check the checkbox labeled "If checked, DAG names are suffixed with the DAG ID"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Data Entry Log - v0.0.0"

    # Filtering
    When I click on the link labeled "Data Entry Log"
    #VERIFY E.127.1000
    Then I should NOT see "Complete?"
    #VERIFY E.127.800
    And I should see a table header and rows containing the following values in the a table:
      | Username   | Record ID | Group     | Event        | Arm         | Instance | Form            | Field and Label                                        | New Value         | Action        |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   | 3        | data_types	     | data_types_crfver [CRF Versioning]                     | 1                 | Update record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   | 3        | data_types	     | ptname [Name]	                                        | Test User1        | Update record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   | 3        | data_types	     | notesbox [Notes Box]	                                  | Notes             | Update record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   | 3        | data_types	     | file_upload [File Upload]                              | 2                 | Update record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   | 2        | data_types	     | data_types_crfver [CRF Versioning]                     | 1                 | Update record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   | 2        | data_types	     | ptname [Name]	                                        | Test User1        | Update record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   | 2        | data_types	     | checkbox [Checkbox]            	                      | item[1] checked   | Update record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   | 2        | data_types	     | checkbox [Checkbox]           	                        | item[2] checked   | Update record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   |          | data_types	     | data_types_crfver [CRF Versioning]                     | 1                 | Create record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   |          | data_types	     | ptname [Name]	                                        | Test User1        | Create record |
      | test_user1 | 1-2       | DAG1 [1]  | Event 1 [40] | Arm 1 [1]   |          | data_types	     | radio_button_auto [Radio Button Auto]                  | 1                 | Create record |
      | test_user1 | 1-1       | DAG1 [1]  | Event 2 [41] | Arm 1 [1]   |          | text_validation | text_validation_crfver [CRF Versioning]                | 1                 | Create record |
      | test_user1 | 1-1       | DAG1 [1]  | Event 2 [41] | Arm 1 [1]   |          | text_validation | email_v2 [Email]	                                      | testuser1@abc.com | Create record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types      | data_types_crfver [CRF Versioning]                     | 1                 | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types      | ptname [Name]	                                        | Test User1        | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types      | radio_button_manual [Radio Button Manual]              | 9..9              | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types      | required [Required]                                    | 2001              | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] |          | data_types      | ptname [Name]                                          | User 2            | Create record |

    And I should see 19 rows in the data entry log table

    When I select "test_user2" on the dropdown field labeled "Username"
    Then I should see a table header and rows containing the following values in the a table:
      | Username   | Record ID | Group     | Event        | Arm         | Instance | Form       | Field and Label                           | New Value       | Action        |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types | data_types_crfver [CRF Versioning]        | 1               | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types | ptname [Name]	                            | Test User1      | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types | radio_button_manual [Radio Button Manual] | 9..9            | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types | required [Required]                       | 2001            | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] |          | data_types | data_types_crfver [CRF Versioning]        | 1               | Create record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] |          | data_types | ptname [Name]                             | User 2          | Create record |
    
    And I should see 6 rows in the data entry log table

    #VERIFY E.127.900
    When I click on the button labeled "Past year"
    Then I should see "The request was not run - choose all records and max window of 10 days or choose a record and any time window"
    And I should see "No log entries found"

    When I click on the link labeled "Data Entry Log"
    And I select "Arm Two [2]" on the dropdown field labeled "Arm"
    And I select "2" on the dropdown field labeled "Instance"
    And I select "Event 1 [43]" on the dropdown field labeled "Event"
    Then I should see a table header and rows containing the following values in the a table:
      | Username   | Record ID | Group     | Event        | Arm         | Instance | Form       | Field and Label                           | New Value       | Action        |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types | data_types_crfver [CRF Versioning]        | 1               | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types | ptname [Name]	                            | Test User1      | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types | radio_button_manual [Radio Button Manual] | 9..9            | Update record |
      | test_user2 | 2-1       | DAG2 [2]  | Event 1 [43] | Arm Two [2] | 2        | data_types | required [Required]                       | 2001            | Update record |

    And I should see 4 rows in the data entry log table
    And I should NOT see "Arm 1"
    And I should NOT see "Event 1 [40]"
    And I should NOT see "Event 2 [41]"

  Scenario: E.127.100 - Disable external module
    # Disable external module in project
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Data Entry Log - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Data Entry Log - v0.0.0"

    Given I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
      | Date / Time      | Username   | Action                                                                       | List of Data Changes OR Fields Exported                                                                                                                                                             |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "data_entry_log_v0.0.0" for project                  |                                                                                                                                                                                                     |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "data_entry_log_v0.0.0" for project | reserved-hide-from-non-admins-in-project-list, max-days-all-records, always-exclude-fields-with-regex, display-event-id-with-event-name, display-arm-id-with-arm-name, display-dag-id-with-dag-name |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "data_entry_log_v0.0.0" for project                   |                                                                                                                                                                                                     |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Data Entry Log - v0.0.0"

    # Not checking 'Delete Version' for now as this is used for deleting lower versions.
    # If the entire EM is deleted REDCap throws an error

    Given I click on the link labeled "User Activity Log"
    Then I should see a table header and row containing the following values in a table:
      | Time             | User       | Event                                                                        |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "data_entry_log_v0.0.0" for system                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "data_entry_log_v0.0.0" for project                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "data_entry_log_v0.0.0" for project |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "data_entry_log_v0.0.0" for project                   |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "data_entry_log_v0.0.0" for system                    |

    And I logout

    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - data_entry_log"