Feature: User Interface: The system shall support the e-Consent Framework to hide or unhide active and inactive surveys.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.2000.100 e-Consent Framework to hide or unhide active and inactive surveys.
      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      When I click on the link labeled "Project Setup"
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
      Then I should see Project status: "Production"

   #FUNCTIONAL_REQUIREMENT
   Scenario: ##ACTION: e-consent survey settings - enabled
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent"
      Then I should see a checkbox labeled "Hide inactive" that is checked
      And I should see the e-consent framework for survey labeled "Participant Consent" is "Active"

      #VERIFY: Verify version enabled
      When I click on the button labeled "View all versions" for the survey labeled "Participant Consent"
      Then I should see a table header and rows containing the following values in a table:
         | Active?    | Version | Time added | Uploaded by | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
         | check icon | 1.0     |            |             | 0                           |                   |              | 20240718153905_Fake_Consent[311203].pdf | "Set as inactive" button     |

   Scenario: #Verify eConsent Framework is active by adding a record
      ##ACTION: add record
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

      And I click on the button labeled "Save signature" in the dialog box

      When I click on the button labeled "Next Page"
      Then I should see "Displayed below is a read-only copy of your survey responses."
      And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

      When I check the checkbox labeled "I certify that all of my information in the document above is correct."
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"

   #FUNCTIONAL_REQUIREMENT
   Scenario: ##ACTION: e-consent survey settings - disabled
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent"
      And I uncheck the checkbox labeled "Hide inactive"
      And I "Inactive" the e-consent framework for survey labeled "Participant Consent"
      And I click on the button labeled "Set as inactive"
      Then I should see the e-consent framework for survey labeled "Participant Consent" is "Inactive"

      #VERIFY: Verify version enabled
      When I click on the button labeled "View all versions" for the survey labeled "Participant Consent"
      Then I should see a table header and rows containing the following values in a table:
         | Active?    | Version | Time added | Uploaded by | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
         | check icon | 1.0     |            |             | 1                           |                   |              | 20240718153905_Fake_Consent[311203].pdf | "Set as inactive" button     |

   Scenario: #Verify eConsent Framework is inactive by adding a record
      ##ACTION: add record
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

      And I click on the button labeled "Save signature" in the dialog box

      When I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"

   #FUNCTIONAL_REQUIREMENT=
   Scenario: ##ACTION: e-consent survey settings - enabled
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent"
      And I uncheck the checkbox labeled "Hide inactive"
      And I "Active" the e-consent framework for survey labeled "Participant Consent"
      Then I should see "e-Consent successfully"
      And I should see the e-consent framework for survey labeled "Participant Consent" is "Active"

      #VERIFY: Verify version enabled
      When I click on the button labeled "View all versions" for the survey labeled "Participant Consent"
      Then I should see a table header and rows containing the following values in a table:
         | Active?    | Version | Time added | Uploaded by | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
         | check icon | 1.0     |            |             | 2                           |                   |              | 20240718153905_Fake_Consent[311203].pdf | "Set as inactive" button     |

   Scenario: #Verify eConsent Framework is active by adding a record
      ##ACTION: add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
      Then I should see "Adding new Record ID 3."

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

      And I click on the button labeled "Save signature" in the dialog box

      When I click on the button labeled "Next Page"
      Then I should see "Displayed below is a read-only copy of your survey responses."
      And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

      When I check the checkbox labeled "I certify that all of my information in the document above is correct."
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"

   Scenario: Verification e-Consent saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)        | Version | Type                  |
         | .pdf | YES                              | 3      | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LatName, 2000-01-01 |         | e-Consent Participant |
         | .pdf |                                  | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                               |         | e-Consent             |
         | .pdf | YES                              | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LatName, 2000-01-01 |         | e-Consent Participant |

      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
         | Username            | Action                    | List of Data Changes OR Fields                                                                                                                             |
         | [survey respondent] | Save PDF Snapshot 3       | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "3" event = "event_1_arm_1" instrument = "participant_consent"" |
         | [survey respondent] | e-Consent Certification 3 | e-Consent Certification record = "3"  event = "event_1_arm_1" instrument = "participant_consent"                                                           |
         | [survey respondent] | Save PDF Snapshot 2       | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "2" event = "event_1_arm_1" instrument = "participant_consent"" |  
         | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent"" |
         | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1"  event = "event_1_arm_1" instrument = "participant_consent"                                                           |
#END