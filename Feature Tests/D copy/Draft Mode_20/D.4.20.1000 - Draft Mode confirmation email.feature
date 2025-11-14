Feature: D.4.20.1000 - User Interface: The system shall allow for a confirmation email to be sent to the requestor which is templated but allows for additional information to be entered.

    As a REDCap end user
    I want to see that Draft Mode is functioning as expected

    Scenario: D.4.20.1000 Detailed summary of drafted changes
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        Then I should see "System-level User Settings"
        Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
        And I select "Never (always require an admin to approve changes)" on the dropdown field labeled "Allow production Draft Mode changes to be approved automatically under certain conditions"
        When I click on the button labeled "Save Changes"
        And I see "Your system configuration values have now been changed!"

        # EMAIL ADDRESS SET FOR REDCAP ADMIN - without it, emails are not send out from system
        Given I click on the link labeled "General Configuration"
        Then I should see "General Configuration"
        When I enter "redcap@test.instance" into the input field labeled "Email Address of REDCap Administrator"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed"
        Then I logout

        #SETUP
        Given I login to REDCap with the user "Test_User1"
        And I create a new project named "D.4.20.1000" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see Project status: "Production"

        ##ACTION: Draft Mode
        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        When I click on the instrument labeled "Data Types"
        And I click on the Edit image for the field named "Radio Button Manual"
        And I enter Choices of "102, Choice102" into the open "Edit Field" dialog box
        And I click on the button labeled "Save" in the "Edit Field" dialog box
        And I click on the Add Field input button below the field named "Radio Button Manual"

        Given I select "Notes Box (Paragraph Text)" on the dropdown field labeled "Field Type:"
        And I enter "Notes Box" into the Field Label of the open "Add New Field" dialog box
        And I enter "notesbox4" into the Variable Name of the open "Add New Field" dialog box
        And I click on the button labeled "Save"
        Then I should see the field labeled "Notes Box"

        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I logout

        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Browse Projects"
        And I enter "D.4.20.1000" into the input field labeled "Search project title by keyword(s):"
        And I click on the button labeled "Search project title"
        And I click on the link labeled "D.4.20.1000"
        And I click on the link labeled "Designer"
        When I click on the button labeled "Project Modification Module"
        And I click on the button labeled "Compose confirmation email"
        And I click on the button labeled "Send Email" in the dialog box
        Then I should see "EMAIL SENT" in the dialog box
        And I click on the button labeled "Close" in the dialog box
        Then I logout

        Given I open Email
        # Automatic Email to REDCap admin to review Draft changes
        Then I should see 1 email for user "redcap@test.instance"
        # Email to user who submitted the Draft changes
        Then I should see 1 email for user "Test_User1@test.edu"

        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Browse Projects"
        And I enter "D.4.20.1000" into the input field labeled "Search project title by keyword(s):"
        And I click on the button labeled "Search project title"
        And I click on the link labeled "D.4.20.1000"
        And I click on the link labeled "Designer"
        When I click on the button labeled "Project Modification Module"
        And I click on the button labeled "COMMIT CHANGES"
        And I click on the button labeled "COMMIT CHANGES" in the dialog box
        Then I should see "Project Changes Committed / User Notified"
        And I logout

        #VERIFY: Email Confirmation to requestor
        Given I open Email
        Then I should see an email for user "Test_User1@test.edu" with subject "[REDCap] Project Changes were Approved"
#END