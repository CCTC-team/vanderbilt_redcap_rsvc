Feature: D.104.300 - The system shall support the ability to send a survey after a specified time when a logic becomes true and/or when another survey is completed.

  As a REDCap end user
  I want to see that automated survey invitations work as expected

  Scenario: D.104.200 - Send Survey When Survey Completed
    
    Given I login to REDCap with the user "Test_User1"
    Then I create a new project named "D.104.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/D104300.xml", and clicking the "Create Project" button
   
    #Verify surveys are enabled in the project and email field is designated
    Given I click on the link labeled "Project Setup"
    And I should see a button labeled "Disable" in the "Use surveys in this project?" row in the "Main project settings" section
    Then I should see "Field currently designated: email"

    #Modify ASI
    Given I click on the link labeled "Designer"
    And I click on the button labeled "Automated Invitations"
    When I click on the last button labeled "Modify"
    And I check the checkbox labeled "When the following logic becomes true:"
    And I click on "" in the textarea field labeled "When the following logic becomes true" in the dialog box
    And I should see a dialog containing the following text: "Logic Editor"
    And I clear field and enter "[event_1_arm_1][lname] != ''" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" 
    And I check the checkbox labeled "Ensure logic is still true before sending invitation?"
    When I enter 0 days 0 hours and 1 minute for When to send invitations AFTER conditions are met
    When I click on the button labeled "Save" in the dialog box
    Then I should see a dialog containing the following text: "Copy Automated Invitation settings to other surveys"    
    And I click on the button labeled "Cancel" in the dialog box

    #Re-evaluate surveys
    And I click on the button labeled "Auto Invitation options"
    When I click on the link labeled "Re-evaluate Automated Survey Invitations"
    When I click on the button labeled "Re-evaluate selected surveys"
    Then I should see "Nothing changed!"
    And I click on the button labeled "OK"

    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action                                   | List of Data Changes OR Fields Exported                          |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design                            | Re-evaluate automated survey invitations:                        |
      | mm/dd/yyyy hh:mm | test_user1 | Re-evaluate Automated Survey Invitations | 0 records were affected.                                         |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design                            | Edit settings for automated survey invitations                   |
      | mm/dd/yyyy hh:mm | SYSTEM	    | Manage/Design                            | Automatically schedule survey invitation                         |
      | mm/dd/yyyy hh:mm | SYSTEM	    | Manage/Design                            | (Record: "1", Survey: "Survey", Event: "Event 1", Instance: "1") |
    
    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Demographics" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I clear field and enter "joe@abc.com" into the data entry form field labeled "Email"
    Then I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

    Given I click on the link labeled "Survey Distribution Tools"
    Then I should see "Participant List"
    And I click on the tab labeled "Survey Invitation Log"
    When I click on the button labeled "View past invitations"
    Then I should see a table header and rows containing the following values in a table:
      | Invitation send time | Participant Email | Record | Survey         |
      |                      | joe@abc.com       | 1      | Survey Event 1 |
    
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event 1" for record ID "1" and click on the bubble
    When I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Survey"
    When I enter "1" into the data entry form field labeled "Reminder"
    And I enter "description" into the data entry form field labeled "Description"
    Then I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"

    When I return to the REDCap page I opened the survey from
    And I wait for 70 seconds
    And I click on the link labeled "Survey Distribution Tools"
    Then I should see "Participant List"
    And I click on the tab labeled "Survey Invitation Log"
    When I click on the button labeled "View past invitations"
    Then I should see a table header and rows containing the following values in a table:
      | Invitation send time | Participant Email | Record | Survey         |
      |                      | joe@abc.com       | 1      | Survey Event 1 |

    And I should NOT see "Survey Event 2"
    When I click on the button labeled "View future invitations"
    Then I should see "No invitations to list"

    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Demographics" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I enter "George" into the data entry form field labeled "Last name"
    And I enter "Joe" into the data entry form field labeled "First name"
    Then I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

    Given I click on the link labeled "Survey Distribution Tools"
    Then I should see "Participant List"
    And I click on the tab labeled "Survey Invitation Log"
    When I click on the button labeled "View past invitations"
    Then I should see a table header and rows containing the following values in a table:
      | Invitation send time | Participant Email | Record | Survey         |
      |                      | joe@abc.com       | 1      | Survey Event 1 |
      |                      | joe@abc.com       | 1      | Survey Event 2 |
    
    And I logout