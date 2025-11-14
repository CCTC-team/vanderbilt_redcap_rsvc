Feature: D.102.300 - The system shall support the ability to send emails If conditional logic is TRUE when a record is saved on a specific form/survey

    As a REDCap end user
    I want to see that Alerts and Notifications is functioning as expected

    Scenario: D.102.300 Send emails If conditional logic is TRUE when a record is saved on a specific form/survey.
        Given I login to REDCap with the user "Test_User1"   
        And I create a new project named "D.102.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button
        When I click on the link labeled "Designer"
        And I click on the instrument labeled "Data Types"
        And I click on the Edit image for the field named "Text Box"
        And I click on the textarea labeled "Action Tags / Field Annotation"
        Then I clear field and enter "@CALCTEXT(if([ptname] != '', 'Pass', 'Fail'))" in the textarea field labeled "Logic Editor" in the dialog box
        And I click on the button labeled "Update & Close Editor"
        And I click on the button labeled "Save"

        When I click on the link labeled "Alerts & Notifications"
        Then I should NOT see "Alert #1:Email Alert"
        And I click on the button labeled "Add New Alert"
        Then I should see "Create new alert"
        And I enter "Email-Alert" into the input field labeled "Title of this alert"
        And I select the radio option "If conditional logic is TRUE when a record is saved on a specific form/survey" for How will this alert be triggered
        And I select '"Data Types" (Event 1 (Arm 1: Arm 1))' on the dropdown field for alert form name
        And I should see the dropdown field for alert form status with the option "is saved with any form status" selected
        And I click on the textarea labeled while the following logic is true for the alert
        And I clear field and enter "[textbox]='Pass'" in the textarea field labeled "Logic Editor" in the dialog box
        And I click on the button labeled "Update & Close Editor"
        And I check the checkbox labeled "Ensure logic is still true before sending notification?"
        And I should see the radio option "Send immediately" for When to send the alert selected
        And I should see the radio option "Just once" for Send it how many times selected
        And I should see the radio option "Email" for Alert Type selected
        Then I enter "Testing-Alerts-and-Notifications" into the alert message
        And I enter "Alerts-and-Notifications" into the input field labeled "Subject"
        And I enter "test_user2@example.com" into the input field labeled "Email To"
        When I save the alert
        Then I should see "Success! New alert created"
        And I should see "Alert #1:Email-Alert"
            
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
        Then I should see "Fail" in the data entry form field "Text Box"
        And I click on the button labeled "Save & Exit Form"
        And I should see "Record ID 2 successfully added"
        And I logout

        ##VERIFY: Verify email is not in MailHog 
        Given I open Email
        Then I should NOT see "Alerts-and-Notifications"
        
        # Login to REDCap
        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "D.102.300"
        And I click on the link labeled "Alerts & Notifications"
        When I click on the tab labeled "Notification Log"
        Then I should see "No notifications to list"
        When I click on the button labeled "View past notifications"
        Then I should see "No notifications to list"

        Given I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "2" and click on the bubble
        Then I should see "Fail" in the data entry form field "Text Box"
        When I enter "User2" into the input field labeled "Name"
        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        Then I should see "Pass" in the data entry form field "Text Box"
        And I click on the button labeled "Cancel"
        
        Given I click on the link labeled "Alerts & Notifications"
        When I click on the tab labeled "Notification Log"
        And I click on the button labeled "View past notifications"
        Then I should see a table header and rows containing the following values in the a table:
            | Notification send time | Alert    | Record                          | Recipient              | Subject                  | 
            | mm/dd/yyyy hh:mm       | #1 (A-1) | 2 (#1) - Event 1 (Arm 1: Arm 1) | test_user2@example.com | Alerts-and-Notifications |
       
        And I logout

        ##VERIFY: Verify email in MailHog 
        Given I open Email
        Then I should see an email for user "test_user2@example.com" with subject "Alerts-and-Notifications"

    Scenario: D.102.600 - Verify Download alert settings
        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "D.102.300"
        And I click on the link labeled "Alerts & Notifications"
        When I click on the button labeled "Upload or download Alerts"
        Then I should see "Upload Alerts (CSV)"
        And I click on the link labeled "Download Alerts (CSV)"
        Then I should have the latest downloaded "csv" file that contains the headings and rows below
            | alert-unique-id | alert-title | alert-trigger | unique-form-name | unique-event-name | saved-with-form-status | alert-condition  | ensure-logic-still-true | alert-stop-type | send-on | send-on-next-day-type | send-on-next-time | send-on-time-lag-days | send-on-time-lag-hours | send-on-time-lag-minutes | send-on-field-after | send-on-field | send-on-date | alert-send-how-many | every-time-type | repeat-for | repeat-for-units | repeat-for-max | alert-expiration | alert-type | email-from-display  | email-from          | email-to               | email-cc | email-bcc | email-failed | email-subject            | alert-message                           | sendgrid-template-id | sendgrid-template-data | sendgrid-mail-send-configuration | prevent-piping-identifiers | file-upload-fields | phone-number-to | alert-deactivated |
            | A-1             | Email-Alert | SUBMIT-LOGIC  | data_types       | event_1_arm_1     | ANY                    | [textbox]='Pass' | Y                       | RECORD          | NOW     |                       |                   |                       |                        |                          |                     |               |              | ONCE                |                 |            |                  |                |                  | EMAIL      |                     | Test_User1@test.edu | test_user2@example.com |          |           |              | Alerts-and-Notifications | <p>Testing-Alerts-and-Notifications</p> |                      | {}                     | {}                               | Y                          |                    |                 | N                 |