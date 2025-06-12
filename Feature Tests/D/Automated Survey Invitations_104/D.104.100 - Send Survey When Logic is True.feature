Feature: D.104.100 - The system shall support the ability to send a survey when a logic becomes true 

  As a REDCap end user
  I want to see that automated survey invitations work as expected

  Scenario: D.104.100 - Send Survey When Logic is True
    Given I login to REDCap with the user "Test_User1"
    Then I create a new project named "D.104.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_Survey.xml", and clicking the "Create Project" button
   
    # Enable surveys in the project and designate email field
    Given I click on the link labeled "Project Setup"
    Then I should see a button labeled "Enable" in the "Use surveys in this project?" row in the "Main project settings" section
    And I click on the button labeled "Enable" in the "Use surveys in this project?" row in the "Main project settings" section
    Then I should see "Saved!"
    And I should see a button labeled "Disable" in the "Use surveys in this project?" row in the "Main project settings" section
    When I click on the button labeled "Enable" in the "Designate an email field for communications (including survey invitations and alerts)" row in the "Enable optional modules and customizations" section
    Then I select 'email "Email"' on the dropdown field labeled "Choose an email field to use for invitations to survey participants:"
    And I click on the last button labeled "Save"
    Then I should see "Field currently designated: email"

    # Enable instrument as a survey
    Given I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"
    And I click on the "Enable" button for the instrument row labeled "Survey"
    And I click on the button labeled "Save Changes"
    Then I should see the enabled survey icon link for the instrument row labeled "Survey"
    
    When I click on the button labeled "Automated Invitations"
    Then I should see "Automated Invitations"
    And I click on the first button labeled "+Set up"
    Then I should see "Define Conditions for Automated Survey Invitations (ASI)"
    And I click on the radio labeled "Active"
    And I enter "Testing Survey Event 1" into the input field labeled "Subject:"
    And I check the checkbox labeled "When the following logic becomes true:"
    And I click on "" in the textarea field labeled "When the following logic becomes true" in the dialog box
    And I should see a dialog containing the following text: "Logic Editor"
    And I clear field and enter "[fname]!='' and [email]!=''" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" 
    And I check the checkbox labeled "Ensure logic is still true before sending invitation?"
    And I click on the radio labeled "Send immediately"
    And I check the checkbox labeled "Re-send invitation as a reminder if participant has not responded by a specified time?"
    And I click on the radio labeled Send every for time lag
    When I enter 0 days 0 hours and 1 minute for Enable reminders
    And I select "Send up to 2 times" on the dropdown field labeled "Recurrence"
    When I click on the button labeled exactly "Save"
    Then I should see "Settings for automated invitations were successfully saved!"
    And I click on the button labeled "Close" in the dialog box
    Then I should see "Automated Invitations"

    Given I click on the button labeled "+Set up"
    Then I should see "Define Conditions for Automated Survey Invitations (ASI)"
    And I click on the radio labeled "Active"
    And I enter "Testing Survey Event 2" into the input field labeled "Subject:"
    And I check the checkbox labeled "When the following survey is completed:"
    And I select '"Survey" - Event 1' from the dropdown option for When the following survey is completed
    And I click on the radio labeled "Send immediately"
    When I click on the button labeled exactly "Save"
    Then I should see "Settings for automated invitations were successfully saved!"
    And I click on the button labeled "Close" in the dialog box
    Then I should see "Automated Invitations"

    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported       |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Add settings for automated survey invitations |

    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    When I click the bubble to select a record for the "Demographics" longitudinal instrument on event "Event 1"
    And I enter "George" into the data entry form field labeled "Last name"
    And I enter "Joe" into the data entry form field labeled "First name"
    And I enter "joe@abc.com" into the data entry form field labeled "Email"
    Then I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

    Given I click on the link labeled "Survey Distribution Tools"
    Then I should see "Participant List"
    And I click on the tab labeled "Survey Invitation Log"
    When I click on the button labeled "View past invitations"
    Then I should see a table header and rows containing the following values in a table:
      | Invitation send time | Participant Email | Record | Survey         |
      |                      | joe@abc.com       | 1      | Survey Event 1 |

    When I click on the button labeled "View future invitations"
    Then I should see a table header and rows containing the following values in a table:
      | Invitation send time | Participant Email | Record | Survey         |
      | ( 1)                 | joe@abc.com       | 1      | Survey Event 1 |
      | ( 2)                 | joe@abc.com       | 1      | Survey Event 1 |

    Then I wait for 65 seconds
    And I click on the link labeled "Survey Distribution Tools"
    Then I should see "Participant List"
    And I click on the tab labeled "Survey Invitation Log"
    When I click on the button labeled "View past invitations"
    Then I should see a table header and rows containing the following values in a table:
      | Invitation send time | Participant Email | Record | Survey         |
      |                      | joe@abc.com       | 1      | Survey Event 1 |
      | ( 1)                 | joe@abc.com       | 1      | Survey Event 1 |

    When I click on the button labeled "View future invitations"
    Then I should see a table header and rows containing the following values in a table:
      | Invitation send time | Participant Email | Record | Survey         |
      | ( 2)                 | joe@abc.com       | 1      | Survey Event 1 |

    Then I wait for 80 seconds
    And I click on the link labeled "Survey Distribution Tools"
    Then I should see "Participant List"
    And I click on the tab labeled "Survey Invitation Log"
    When I click on the button labeled "View past invitations"
    Then I should see a table header and rows containing the following values in a table:
      | Invitation send time | Participant Email | Record | Survey         |
      |                      | joe@abc.com       | 1      | Survey Event 1 |
      | ( 1)                 | joe@abc.com       | 1      | Survey Event 1 |
      | ( 2)                 | joe@abc.com       | 1      | Survey Event 1 |

    When I click on the button labeled "View future invitations"
    Then I should see "No invitations to list"

    Given I click on the link labeled "Designer"
    And I click on the button labeled "Auto Invitation options"
    When I click on the link labeled "Download all Automated Survey Invitations settings (CSV)"
    Then the downloaded CSV with filename "asi_export_pid13.csv" has the header and rows below
      | form_name | event_name    | condition_surveycomplete_form_name | condition_surveycomplete_event_name | num_recurrence | units_recurrence | active | email_subject          | email_sender        | condition_andor | condition_logic             | condition_send_time_option | condition_send_time_lag_field_after | delivery_type | reminder_type   | reminder_timelag_days | reminder_timelag_hours | reminder_timelag_minutes | reminder_num | reeval_before_send |
      | survey    | event_1_arm_1 |                                    |                                     | 0              | DAYS             | 1      | Testing Survey Event 1 | test_user1@test.edu | AND             | [fname]!='' and [email]!='' | IMMEDIATELY                | after                               | EMAIL         | TIME_LAG        | 0                     | 0                      | 1                        | 2            | 1                  |
      | survey    | event_2_arm_1 | survey                             | event_1_arm_1                       | 0              | DAYS             | 1      | Testing Survey Event 2 | test_user1@test.edu | AND             |                             | IMMEDIATELY                | after                               | EMAIL         |                 |                       |                        |                          | 0            | 0                  |

    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported                          |
      | mm/dd/yyyy hh:mm | SYSTEM	    | Manage/Design | Automatically schedule survey invitation                         |
      | mm/dd/yyyy hh:mm | SYSTEM	    | Manage/Design | (Record: "1", Survey: "Survey", Event: "Event 1", Instance: "1") |

    # ASI 2
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event 1" for record ID "1" and click on the bubble
    When I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    ##VERIFY
    Then I should see "Survey"
    When I enter "1" into the data entry form field labeled "Reminder"
    And I enter "description" into the data entry form field labeled "Description"
    Then I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"

    When I return to the REDCap page I opened the survey from
    And I click on the link labeled "Survey Distribution Tools"
    Then I should see "Participant List"
    And I click on the tab labeled "Survey Invitation Log"
    When I click on the button labeled "View past invitations"
    Then I should see a table header and rows containing the following values in a table:
      | Invitation send time | Participant Email | Record | Survey         |
      |                      | joe@abc.com       | 1      | Survey Event 1 |
      |                      | joe@abc.com       | 1      | Survey Event 2 |
    And I logout