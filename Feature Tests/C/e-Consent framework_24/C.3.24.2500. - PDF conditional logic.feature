Feature: User Interface: The system shall support conditional logic integration within PDF Snapshots.
   As a REDCap end user
   I want to see that eConsent is functioning as expected

  Scenario: C.3.24.2500.100 PDF snapshots conditional logic
      #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.2500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button
      #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

  Scenario: New PDF Trigger testing Every time the following survey is completed
      ##ACTION: New PDF Trigger with survey based Every time the following survey is completed
    When I click on the button labeled "Designer"
    And I click on the button labeled "PDF Snapshot"
    And I click on the button labeled "PDF Snapshots of Record"
    And I click on the button labeled "+Add new trigger"
    And I enter "Snapshot 1" in the box labeled "Name of trigger"
    And I select "'Participant Consent' - Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
    And I enter "" into the input field labeled "[All instruments]"
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "Snapshot 1" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name       | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot |
      | Active | Edit Copy     | Snapshot 1 | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository                  |

  Scenario: New PDF Trigger testing When the following logic becomes true (only once per record)
      ##ACTION: When the following logic becomes true (only once per record)
    When I click on the button labeled "+Add new trigger"
    And I enter "Snapshot 2" in the box labeled "Name of trigger"
    And I select "--- select a survey ---" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
    And I enter "[participant_consent_complete]='2'" in the box labeled "When the following logic becomes true"
    And I enter "" into the input field labeled "[All instruments]"
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "Snapshot 2" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name       | Type of trigger   | Save snapshot when...                                  | Scope of the snapshot | Location(s) to save the snapshot |
      | Active | Edit Copy     | Snapshot 2 | Logic-based       | Logic becomes true: [participant_consent_complete]='2' | All instruments       | File Repository                  |
      | Active | Edit Copy     | Snapshot 1 | Survey completion | Complete survey "Participant Consent"                  | All instruments       | File Repository                  |

  Scenario: New PDF Trigger testing multi-form
   #C.3.24.2600.100 multi-form/survey PDF snapshots
   ##ACTION: When the following logic becomes true (only once per record)
    When I click on the button labeled "+Add new trigger"
    And I enter "Snapshot 3" in the box labeled "Name of trigger"
    And I select "--- select a survey ---" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
    And I enter "[participant_consent_complete]='2' and [coordinator_signature_complete]='2'" in the box labeled "When the following logic becomes true"
    And I enter "" into the input field labeled "[All instruments]"
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "Snapshot 3" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name       | Type of trigger   | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot |
      | Active | Edit Copy     | Snapshot 3 | Logic-based       | Logic becomes true: [participant_consent_complete]='2... | All instruments       | File Repository                  |
      | Active | Edit Copy     | Snapshot 2 | Logic-based       | Logic becomes true: [participant_consent_complete]='2'   | All instruments       | File Repository                  |
      | Active | Edit Copy     | Snapshot 1 | Survey completion | Complete survey "Participant Consent"                    | All instruments       | File Repository                  |
      ##VERIFY_Logging - Manage/Designof the triggers
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported        |
      | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |
      | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |
      | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |

  Scenario: Add record
      #Add record in
    When I click on the link labeled "Add/Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 1."
    When I click on the button labeled "Save & Stay"
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Participant Consent"
    When I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastName" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "Email"
    And I enter "2000-01-01" into the input field labeled "DOB"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I click on the button labeled "Leave without saving changes" in the dialog box
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"
    And I should see "Incomplete" icon for the Data Collection Instrument labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"
    When I click on the bubble labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"
    Then I should see "custom" in the field labeled "Participant Consent file"
    When I click on the file link the field labeled "Participant Consent file"
    Then I should have a pdf file with the following values "Participant Consent"
      #Manual: Close document
      #Add Insturment 2's response
    When I click on the bubble labeled "Coordiantor Signature"
    Then I should see "Editing existing Record ID 1."
    When I enter a signature in the field labeled "Coordinator's Signature"
    And I click on the button labeled "Save signature" in the dialog box
    And I slect "Complete" from the drowpown labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

  Scenario: Verification pdf saved and logged correctly
      ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name      | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
      | Snapshot3 | -                                |      1 | (Event 1 (Arm 1: Arm 1))                     |                        |         |      |
      | Snapshot2 | -                                |      1 | (Event 1 (Arm 1: Arm 1))                     |                        |         |      |
      | Snapshot1 | -                                |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username            | Action                                   | List of Data Changes OR Fields Exported                                                                                                                                 |
      | test_admin          | Save PDF Snapshot 1                      | Save PDF Snapshot to File Repository record = "1" event = "event_1_arm_1" instrument = "coordinator_signature" snapshot_id =                                            |
      | [survey respondent] | Save PDF Snapshot 1                      | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id = |
      | [survey respondent] | Save PDF Snapshot 1                      | Save PDF Snapshot to File Repository record = "1" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id =                                              |
      | test_admin          | Create record 1 (Event 1 (Arm 1: Arm 1)) | record_id = '1'                                                                                                                                                         |
#END
