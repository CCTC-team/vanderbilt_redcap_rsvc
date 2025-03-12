Feature: User Interface: The system shall support the e-Consent Framework to provide a certification page at the end of the survey that displays an in-line PDF copy of their survey responses.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.705.100 Verify certification page

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.0705.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see Project status: "Production"

    Scenario: add record with consent framework
        ##ACTION: add record with consent framework
        When I click on the link labeled "Add/Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Adding new Record ID 1."

        When I click on the button labeled "Save & Stay"
        And I click on the button labeled "Okay" in the dialog box
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        Then I should see "Participant Consent"

        When I enter "FirstName" into the input field labeled "Name"
        And I enter "LastName" into the input field labeled "Name"
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
        And I should see the button labeled "Submit" is disabled

        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        #Manual: Then I should see the button labeled "Submit" is enabled

        When I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        And I click on the button labeled "Leave without saving changes" in the dialog box
        Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"

    Scenario: Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see a table header and rows containing the following values in a table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type      |
            | .pdf | YES                              | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) | 2000-01-01             |         | e-Consent |


        When I click on the file link for record "1" Survey "Participant Consent (Event 1 (Arm 1: Arm 1))"
        Then I should have a pdf file with "FirstName" into the input field labeled "First Name"

        When I click on the file link for record "2" Survey "Participant Consent (Event 1 (Arm 1: Arm 1))"
        Then I should have a pdf file with "FirstName" into the input field labeled "First Name"
        
        ##VERIFY_Logging
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username            | Action                                     | List of Data Changes OR Fields Exported                                                          |
            | [survey respondent] | e-Consent Certification 1                  | e-Consent Certification record = "1"  event = "event_1_arm_1" instrument = "participant_consent" |
            | [survey respondent] | Update Response 1 (Event 1 (Arm 1: Arm 1)) | first_name = 'FirstName', type_sign1 = 'MyName'                                                  |
#END