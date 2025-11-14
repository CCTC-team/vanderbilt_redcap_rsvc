
Feature: D.102.400 - The system shall support the ability to send emails When conditional logic is TRUE during a data import, data entry, or as the result of time-based logic

  As a REDCap end user
  I want to see that Alerts and Notifications is functioning as expected

  Scenario: D.102.400 Send emails When conditional logic is TRUE during a data import, data entry, or as the result of time-based logic.
    Given I login to REDCap with the user "Test_User1"   
    And I create a new project named "D.102.400" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    # D.102.600 - Upload alert settings
    When I click on the link labeled "Alerts & Notifications"
    Then I should NOT see "Alert #1:Email Alert"
    Given I click on the button labeled "Upload or download Alerts"
    Then I should see "Upload Alerts (CSV)"
    And I click on the link labeled "Upload Alerts (CSV)"
    Then I should see a dialog containing the following text: "Upload Alerts (CSV)"
    When I upload a "csv" format file located at "import_files/redcap_val/D102400_Alerts.csv", by clicking the button near "Select your CSV file of Alerts to be added:" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see a dialog containing the following text: "Upload Alerts (CSV) - Confirm"
    And I should see a table header and rows containing the following values in the a table:
      | alert-title | alert-trigger	|
      | Email Alert | LOGIC         |

    Given I click on the button labeled "Upload" in the dialog box
    Then I should see a dialog containing the following text: "SUCCESS!"
    And I click on the button labeled "Close" in the dialog box
    And I should see "Alert #1:Email Alert"
      
    ##ACTION: Import (with records in rows)
    Given I click on the link labeled "Data Import Tool"
    When I upload a "csv" format file located at "import_files/redcap_val/D.102.400_DataImport.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "Your document was uploaded successfully and is ready for review"
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"

    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "2" and click on the bubble
    Then I should see "" in the data entry form field "Name"
    And I should see "test_user1@abc.com" in the data entry form field "Email"
    And I click on the button labeled "Cancel"
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
    Then I should see "User2" in the data entry form field "Name"
    And I should see "test_user2@abc.com" in the data entry form field "Email"
    And I click on the button labeled "Cancel"

    Given I click on the link labeled "Alerts & Notifications"
    When I click on the tab labeled "Notification Log"
    And I click on the button labeled "View past notifications"
    Then I should see a table header and rows containing the following values in the a table:
        | Notification send time | Alert    | Record                     | Recipient          | Subject                  | 
        | mm/dd/yyyy hh:mm       | #1 (A-2) | 3 - Event 1 (Arm 1: Arm 1) | test_user2@abc.com | Alerts and Notifications |

    ##VERIFY: Verify email in MailHog 
    Given I open Email
    Then I should see an email for user "test_user2@abc.com" with subject "Alerts and Notifications"
    And I should NOT see "test_user1@abc.com"