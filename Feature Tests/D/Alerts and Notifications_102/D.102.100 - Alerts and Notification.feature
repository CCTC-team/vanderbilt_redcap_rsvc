Feature: D.102.100 - The system shall support the ability to send emails when a record is saved on a specific form/survey
    As a REDCap end user
    I want to see that Alerts and Notifications is functioning as expected

  Scenario: D.102.100 - Send alert when a record is saved on a specific form/survey
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "D.102.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: New Alert
    When I click on the link labeled "Alerts & Notifications"
    Then I should NOT see "Alert #1:Email Alert"
    And I click on the button labeled "Add New Alert"
    Then I should see "Create new alert"
    And I enter "Email Alert" into the input field labeled "Title of this alert"
    And I should see the radio option "When a record is saved on a specific form/survey" for How will this alert be triggered selected
    And I select '"Data Types" (Event 1 (Arm 1: Arm 1))' on the dropdown field for alert form name
    And I should see the dropdown field for alert form status with the option "is saved with any form status" selected
    And I should see the radio option "Send immediately" for When to send the alert selected
    And I should see the radio option "Just once" for Send it how many times selected
    And I should see the radio option "Email" for Alert Type selected
    And I scroll to the field labeled "Or manually enter emails"
    And I enter "test_user2@example.com" into the input field labeled "Or manually enter emails"
    Then I enter "Testing Alerts and Notifications" into the alert message
    And I enter "Alerts and Notifications" into the input field labeled "Subject"
    When I save the alert
    Then I should see "Success! New alert created"
    And I should see "Alert #1:Email Alert"
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I enter "Lily Brown" into the data entry form field labeled "Name"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 2 successfully added."
    And I logout

    ##VERIFY: Verify email in MailHog
    Given I open Email
    Then I should see an email for user "test_user2@example.com" with subject "Alerts and Notifications"

    # Login to REDCap
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.102.100"
    And I click on the link labeled "Alerts & Notifications"
    When I click on the tab labeled "Notification Log"
    And I click on the button labeled "View past notifications"
    Then I should see a table header and rows containing the following values in the a table:
      | Notification send time | Alert    | Record                          | Recipient              | Subject                  |
      | mm/dd/yyyy hh:mm       | #1 (A-1) | 2 (#1) - Event 1 (Arm 1: Arm 1) | test_user2@example.com | Alerts and Notifications |
    Given I click on the mail icon for record 2
    Then I should see "Test_User1@test.edu" in the dialog box
    And I should see "test_user2@example.com" in the dialog box
    And I should see "Testing Alerts and Notifications" in the dialog box
    And I should see "Alerts and Notifications" in the dialog box
    Then I click on the button labeled "Close" in the dialog box

  Scenario: D.102.200 - Modify Alerts
    Given I click on the tab labeled "My Alerts"
    When I click on the button labeled "Edit" for alert "1"
    Then I should see "Edit Alert #1" in the dialog box
    And I select "is saved with Complete status only" on the dropdown field for alert form status
    And I scroll to the field labeled "Or manually enter emails"
    And I clear field and enter "test_user3@example.com" into the input field labeled "Or manually enter emails"
    Then I enter "Testing Editing Alerts and Notifications" into the alert message
    And I clear field and enter "Editing Alerts and Notifications" into the input field labeled "Subject"
    When I save the alert
    Then I should see "Success! The alert was updated"
    And I should see "Alert #1:Email Alert"
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I enter "Thomas Stone" into the input field labeled "Name"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 3 successfully added"
    And I logout

    ##VERIFY: Verify email is not in MailHog
    Given I open Email
    Then I should NOT see "Editing Alerts and Notifications"

    # Login to REDCap
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.102.100"
    And I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "3" and click on the bubble
    And I select "Complete" on the dropdown field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 3 successfully edited"
    Given I click on the link labeled "Alerts & Notifications"
    When I click on the tab labeled "Notification Log"
    And I click on the button labeled "View past notifications"
    Then I should see a table header and rows containing the following values in the a table:
      | Notification send time | Alert    | Record                          | Recipient              | Subject                          |
      | mm/dd/yyyy hh:mm       | #1 (A-1) | 2 (#1) - Event 1 (Arm 1: Arm 1) | test_user2@example.com | Alerts and Notifications         |
      | mm/dd/yyyy hh:mm       | #1 (A-1) | 3 (#1) - Event 1 (Arm 1: Arm 1) | test_user3@example.com | Editing Alerts and Notifications |
    And I logout

    ##VERIFY: Sent email in MailHog
    Given I open Email
    Then I should see an email for user "test_user3@example.com" with subject "Editing Alerts and Notifications"

  Scenario: D.102.500 - Copy alert
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "D.102.100"
    And I click on the link labeled "Alerts & Notifications"
    Then I should NOT see "Alert #2:Email Alert"
    When I click on the button labeled "Options" for alert "1"
    And I click on the link labeled "Copy alert"
    Then I should see "Alert #2:Email Alert"
    When I click on the button labeled "Edit" for alert "2"
    Then I should see "Edit Alert #2" in the dialog box
    And I should see the radio option "When a record is saved on a specific form/survey" for How will this alert be triggered selected
    And I should see "Data Types (Event 1 (Arm 1: Arm 1))"
    And I should see the dropdown field for alert form status with the option "is saved with Complete status only" selected
    And I should see the radio option "Send immediately" for When to send the alert selected
    And I should see the radio option "Just once" for Send it how many times selected
    And I should see the radio option "Email" for Alert Type selected
    And I should see "test_user3@example.com"
    And I should see "Editing Alerts and Notifications"
    And I should see "Testing Editing Alerts and Notifications"
    When I cancel the alert
    Then I should see "Alert #2:Email Alert"

  Scenario: D.102.500 - Deactivate alert
    When I click on the button labeled "Options" for alert "2"
    And I click on the link labeled "Deactivate alert"
    Then I should see "Are you sure you want to deactivate this Alert? It can be re-enabled later, if needed."
    When I click on the button labeled "Deactivate" in the dialog box
    Then I should see "Success! The alert was deactivated"
    And I should NOT see "Alert #2:Email Alert"
    When I check the checkbox labeled "Show 1 deactivated alert(s)"
    Then I should see "Alert #2:Email Alert"
    And I should see "DEACTIVATED: Alert was deactivated"

  Scenario: D.102.500 - Re-enable alert
    When I click on the button labeled "Options" for alert "2"
    And I click on the link labeled "Re-enable alert"
    Then I should see "Success! The alert was re-enabled."
    And I should see "No matching records found"
    When I uncheck the checkbox labeled "Show 0 deactivated alert(s)"
    Then I should see "Alert #1:Email Alert"
    And I should see "Alert #2:Email Alert"

  Scenario: D.102.500 - Move alert
    # Edit Subject and Message for alert 2
    Given I click on the button labeled "Edit" for alert "2"
    Then I should see "Edit Alert #2"
    Then I enter "Testing Move Alerts and Notifications" into the alert message
    And I clear field and enter "Move Alerts and Notifications" into the input field labeled "Subject"
    When I save the alert
    Then I should see "Success! The alert was updated."
    # Move alert 1
    Given I click on the button labeled "Options" for alert "1"
    When I click on the link labeled "Move alert"
    And I select "Alert #2: Email Alert (A-2)" on the dropdown field labeled "Move the alert above so that it will be located immediately *AFTER* the following alert:"
    And I click on the button labeled "Move alert" in the dialog box
    Then I should see "The alert was successfully moved to a new location!" in the dialog box
    And I should see "PLEASE NOTE that moving this alert may have caused some or all of the alerts to be re-numbered automatically. They will still retain their same alert title and unique alert ID, but their alert number (#) may have changed because alert numbers are generated on the fly based on the order of the alerts." in the dialog box
    And I click on the button labeled "Close" in the dialog box
    # VERIFY
    When I click on the button labeled "Edit" for alert "1"
    Then I should see "Edit Alert #1"
    And I should see "Move Alerts and Notifications"
    And I cancel the alert
    When I click on the button labeled "Edit" for alert "2"
    Then I should see "Edit Alert #2"
    And I should see "Editing Alerts and Notifications"
    And I cancel the alert

  Scenario: D.102.500 - Permanently delete alert
    Given I click on the button labeled "Options" for alert "1"
    And I click on the link labeled "Deactivate alert"
    Then I should see "Are you sure you want to deactivate this Alert? It can be re-enabled later, if needed."
    When I click on the button labeled "Deactivate" in the dialog box
    Then I should see "Success! The alert was deactivated"
    And I should NOT see "Alert #1:Email Alert"
    When I check the checkbox labeled "Show 1 deactivated alert(s)"
    Then I should see "Alert #1:Email Alert"
    And I should see "DEACTIVATED: Alert was deactivated"
    And I should see "Move Alerts and Notifications"
    When I click on the button labeled "Options" for alert "1"
    And I click on the link labeled "Permanently delete"
    Then I should see "Are you sure you want to delete this Alert?"
    And I should see "This will permanently delete the Alert."
    And I click on the button labeled "Delete" in the dialog box
    Then I should see "Success! The alert was permanently deleted."
    And I should see a checkbox labeled "Show 0 deactivated alert(s)" that is unchecked
    And I should see "Alert #1:Email Alert"
    And I should see "Editing Alerts and Notifications"
    When I check the checkbox labeled "Show 0 deactivated alert(s)"
    Then I should see "No matching records found"
    
    #VERIFY_LOG: Logging Table
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action                                       | List of Data Changes OR Fields Exported                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |  
        | mm/dd/yyyy hh:mm | test_user1 | Manage/Design Permanently delete alert       | Alert #1 (A-2)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |                        
        | mm/dd/yyyy hh:mm | test_user1 | Manage/Design Deactivate  alert              | Alert #1 (A-2)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |                        
        | mm/dd/yyyy hh:mm | test_user1 | Manage/Design Move alert                     | Alert #1: Email Alert (A-1)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |                        
        | mm/dd/yyyy hh:mm | test_user1 | Manage/Design Reactivate  alert              | Alert #2 (A-2)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |                        
        | mm/dd/yyyy hh:mm | test_user1 | Manage/Design Deactivate alert               | Alert #2 (A-2)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |                        
        | mm/dd/yyyy hh:mm | test_user1 | Manage/Design Copy alert                     | Alert #2 (A-2) copied from Alert #1 (A-1)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |                        
        | mm/dd/yyyy hh:mm | test_user1 | Sent alert Record 3 (Event 1 (Arm 1: Arm 1)) | Alert #1 (A-1), From: 'Test_User1@test.edu', To: 'test_user3@example.com', Subject: 'Editing Alerts and Notifications', Message: Testing Editing Alerts and Notifications'                                                                                                                                                                                                                                                                                                                                                                                                                                     |                        
        | mm/dd/yyyy hh:mm | test_user1 | Manage/Design Modify alert                   | Alert #1 (A-1), alert_title = 'Email Alert', alert_type = 'EMAIL', alert_stop_type = 'RECORD', alert_expiration = '', form_name = 'data_types', form_name_event = 'event_1_arm_1', alert_condition = '', ensure_logic_still_true = 'no', prevent_piping_identifiers = 'yes', trigger_on_instrument_save_status = 'complete_status_only', email_from = 'Test_User1@test.edu', email_from_display = '', email_to = 'test_user3@example.com', phone_number_to = '', email_cc = '', email_bcc = '', email_subject = 'Editing Alerts and Notifications', alert_message = 'Testing Editing Alerts and Notifications' | 
        | mm/dd/yyyy hh:mm | test_user1 | Sent alert Record 2 (Event 1 (Arm 1: Arm 1)) | Alert #1 (A-1), From: 'Test_User1@test.edu', To: 'test_user2@example.com', Subject: 'Alerts and Notifications', Message: 'Testing Alerts and Notifications'                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 
        | mm/dd/yyyy hh:mm | test_user1 | Manage/Design Create alert                   | Alert #1 (A-1), alert_title = 'Email Alert', alert_type = 'EMAIL', alert_stop_type = 'RECORD', alert_expiration = '', form_name = 'data_types', form_name_event = 'event_1_arm_1', alert_condition = '', ensure_logic_still_true = 'no', prevent_piping_identifiers = 'yes', trigger_on_instrument_save_status = 'any_status', email_from = 'Test_User1@test.edu', email_from_display = '', email_to = 'test_user2@example.com', phone_number_to = '', email_cc = '', email_bcc = '', email_subject = 'Alerts and Notifications', alert_message = 'Testing Alert and Notifications',                           | 

    And I logout