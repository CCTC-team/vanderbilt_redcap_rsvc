Feature: D.113.100 - The system shall support the ability to add Missing Data Codes to fields. 

      As a REDCap end user
      I want to see that Missing Data Code is functioning as expected 

      Scenario: D.113.100 - Missing Data Code
            Given I login to REDCap with the user "Test_Admin" 
            And I create a new project named "D.113.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

            Given I click on the link labeled "Record Status Dashboard"
            When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
            Then I should NOT see a Missing Code icon for the field labeled "Name"

            #ACTION: Add Missing Data Code
            Given I click on the link labeled "Project Setup"
            And I click on the button labeled "Additional customizations"
            And I scroll to the field labeled "Missing Data Codes"
            # {enter} for newline
            And I clear field and enter "INV, Invalid{enter}" into the textarea field labeled "Missing Data Codes"
            And I enter "UNK, Unknown" into the textarea field labeled "Missing Data Codes"
            Then I click on the button labeled "Save"

            #VERIFY_LOG
            Given I click on the link labeled "Logging"
            Then I should see a table header and row containing the following values in the logging table:
                  | Date / Time      | Username   | Action        | List of Data Changes OR Fields Exported |
                  | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Make project customizations             |

            #ACTION: Mark fields as Missing
            Given I click on the link labeled "Record Status Dashboard"
            When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
            And I click on the Missing Code icon for the field labeled "Name"
            And I add the missing code "Unknown (UNK)"
            Then I should see "UNK" in the data entry form field "Name"
            And I click on the Missing Code icon for the field labeled "Email"
            And I add the missing code "Invalid (INV)"
            Then I should see "INV" in the data entry form field "Email"
            And I click on the button labeled "Save & Exit Form"

            #ACTION: Verify Missing Data Code in report
            Given I click on the link labeled "Data Exports, Reports, and Stats"
            Then I should see "All data (all records and fields)"
            When I click on the button labeled "View Report" for the report named "All data (all records and fields)"
            Then I should see a table header and row containing the following values in a table:
                  | Record ID | Event Name             | Name          | Email         |
                  | 1         | Event 1 (Arm 1: Arm 1) | Unknown (UNK) | Invalid (INV) |

            #ACTION: Verify Missing Data Code in csv download file
            Given I click on the button labeled "Export Data"
            And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
            And I click on the button labeled "Export Data" in the dialog box
            Then I should see a dialog containing the following text: "Data export was successful!"
            And I click on the download icon to receive the file for the "CSV / Microsoft Excel (raw data)" format in the dialog box
            Then I should have the latest downloaded "csv" file that contains the headings and rows below
                  | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | ptname_v2_v2 | email_v2 | text_validation_complete | ptname | text2 | textbox | notesbox | calculated_field | multiple_dropdown_auto | multiple_dropdown_manual | radio_button_auto   | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | checkbox___inv | checkbox___unk | signature | file_upload | required | identifier | identifier_2 | edit_field | data_types_complete |
                  | 1         | event_1_arm_1     |                          |                        |                          | UNK          | INV      | 0                        |        |       |         |          |                  |                        |                          |                     |                     |              |              |              |                |                |           |             |          |            |              |            |                     |
                  | 1         | event_1_arm_1     | data_types               |            1           |                          |              |          |                          |        |       |         |          | 6                |                        |                          |                     |                     | 0            | 0            | 0            | 0              | 0              |           |             |          |            |              |            | 2                   |
            
            And I click on the button labeled "Close" in the dialog box
            And I logout