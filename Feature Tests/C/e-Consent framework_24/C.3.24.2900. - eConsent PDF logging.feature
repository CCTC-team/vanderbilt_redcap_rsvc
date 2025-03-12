Feature: User Interface: The system shall support audit trails for e-Consent Certification and PDF Snapshot generation.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.2900.100 audit trails for e-Consent Certification and PDF Snapshot
      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      When I click on the link labeled "Project Setup"
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see Project status: "Production"

   Scenario: #SETUP_eConsent for participant consent process
      #SETUP_eConsent for participant consent process
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent"
      And I click on the button labeled "+Enable the e-Consent Framework for a survey"
      And I select "Participant Consent" from the dialogue box labeled "Enable e-Consent for a Survey"
      Then I should see a dialogue box labeled "Enable e-Consent"
      And I should see "Primary settings"

      When I check "Allow e-Consent responses to be edited by users?"
      And I select "first_name" on the event name "Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "First name field:" in the dialog box
      And I select "last_name" on the event name "Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "Last name field:" in the dialog box
      And I select "dob" on the event name "Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "Date of birth field:" in the dialog box
      And I enter "Participant" into the input field labeled "e-Consent tag/category:"
      And I enter "PID [project-id] - [last_name]" into the input field labeled "Custom label for PDF header"
      And I select "part_sign Particiant signature" for the field labeled "Signature field #1"
      And I check "Save to a specific field"
      And I select "participant_file" on the event name "Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "select a File Upload field" in the dialog box
      And I enter "eConsent" into the input field labeled "File name:"
      And I click on the button labeled "Save settings"
      Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"
      Then I should see a table header and rows containing the following values in a table:
         | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot    | Custom tag/category | Notes |
         | Active            | "Participant Consent" (participant_consent) | File Repository Specified field:[participant_file] | Participant         |       |

   Scenario: New PDF Trigger for survey completion all instruments
      ##ACTION: New PDF Trigger
      When I click on the button labeled "PDF Snapshots of Record"
      And I click on the button labeled "+Add new trigger"
      And I enter "Snapshot" in the box labeled "Name of trigger"
      And I select "--- select a survey ---" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I enter "[participant_consent_complete]='2'" in the box labeled "When the following logic becomes true"

      And I enter "" into the input field labeled "[All instruments]"
      And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
      And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I check the checkbox labeled "Save to File Repository"
      And I enter "Snapshot" into the input field labeled "File name:"
      And I click on the button labeled "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name     | Type of trigger | Save snapshot when...                                  | Scope of the snapshot | Location(s) to save the snapshot                    |
         | Active | Edit Copy     | Snapshot | Logic-based     | Logic becomes true: [participant_consent_complete]='2' | All instruments       | File Repository Specified field: [participant_file] |

   Scenario: Add record for snapshot
      #Add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
      Then I should see "Adding new Record ID 1."

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

      And I select "Complete" from the field labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I should see "Record Home Page"
      And I should see "Complete" status for "Event 1" insturment "Participant Consent"
      And I should see "Incomplete (no data saved)" icon for the Data Collection Instrument labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"

   Scenario: Add record for eConsent and snapshot
      #Add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
      Then I should see "Adding new Record ID 2."

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

      When I click on the button labeled "Next Page"
      Then I should see "Displayed below is a read-only copy of your survey responses."
      And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

      When I check the checkbox labeled "I certify that all of my information in the document above is correct."
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"
      And I should see an Incomplete Survey Response icon for the Data Collection Instrument labeled "PDF And Combined Signatures PDF" for event "Event 1"

      When I click on the bubble labeled "PDF And Combined Signatures PDF" for event "Event 1"
      Then I should see "Participant Consent file."
      And I should see a file uploaded to the field labeled "PDF And Combined Signatures PDF."
      And I see "econsent"

   Scenario: Verification e-Consent saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name     | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)        |
         | Snapshot | YES                              | 2      | (Event 1 (Arm 1: Arm 1))                     |                               |
         | eConsent | YES                              | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LatName, 2000-01-01 |
         | Snapshot | -                                | 1      | (Event 1 (Arm 1: Arm 1))                     |                               |

      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
         | Username            | Action                    | List of Data Changes OR Fields Exported |
         | [survey respondent] | Save PDF Snapshot 2       | Save PDF Snapshot to File Repository    |
         | [survey respondent] | Save PDF Snapshot 2       | Save PDF Snapshot to File Upload Field  |
         | [survey respondent] | e-Consent Certification 2 | e-Consent Certification                 |
         | test_admin          | Save PDF Snapshot 1       | Save PDF Snapshot to File Repository    |

#END