
Feature: D.3.28.0100. - Control Center: The system shall support the option to configure the storage location for uploaded documents

    As a REDCap end user
    I want to see that eDocse is functioning as expected

    Scenario: D.3.28.0100. - Configure the storage location for uploaded documents
        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Configure the File Vault
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "File Upload Settings"
        Then I should see "Local Server File Storage"
        # Change this path to the edocs folder location
        And I enter "/var/www/html/redcap_file_repository/" into the input field labeled "SET LOCAL FILE STORAGE LOCATION: If using 'Local' storage option, you may set an alternative location for storage of uploaded files (otherwise it will default to 'edocs' folder)."
        Then I click on the button labeled "Save Changes"

    Scenario: Add record to get participant signature
        Given I create a new project named "D.3.28.0100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Participant Consent" longitudinal instrument on event "Event 1"
        Then I should see "Adding new Record ID 1"

        When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Okay" in the dialog box
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        And I clear field and enter "FirstName" into the data entry form field labeled "First Name"
        And I clear field and enter "LastName" into the input field labeled "Last Name"
        And I clear field and enter "email@test.edu" into the input field labeled "Email"
        And I click on the "Today" button for the field labeled "Date of Birth"
        And I clear field and enter "MyName" into the input field labeled "Participant's Name Typed"

        When I click on the "Add signature" link for the field labeled "Participant signature field"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        And I click on the button labeled "Next Page >>"
        And I check the checkbox labeled "I certify that all of my information in the document above is correct"
        And I click on the button labeled "Submit"
        When I click on the button labeled "Close survey"
        Then I should see "You may now close this tab/window"

        ##VERIFY_RSD
        Given I return to the REDCap page I opened the survey from
        Then I should see the "Response was completed"
        And I should see "Survey response is read-only because it was completed via the e-Consent Framework"
   
        ##VERIFY_FiRe
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        And I download the PDF by clicking on the link for Record "1" and Survey "Participant Consent (Event 1 (Arm 1: Arm 1))" in the File Repository table
        Then I should see the following values in the downloaded PDF for Record "1" and Survey "Participant Consent (Event 1 (Arm 1: Arm 1))"
            | First Name                  | FirstName      |
            | Last Name                   | LastName       |
            | Email                       | email@test.edu |
            | Date of Birth               | yyyy-mm-dd     |
            | Participant's Name Typed    | MyName         |
            | Participant signature field |                |

        ##VERIFY_PDF at Specific File Location
        And I should see the following values in the PDF at the local storage
            | First Name                  | FirstName      |
            | Last Name                   | LastName       |
            | Email                       | email@test.edu |
            | Date of Birth               | yyyy-mm-dd     |
            | Participant's Name Typed    | MyName         |
            | Participant signature field |                |

        And I logout