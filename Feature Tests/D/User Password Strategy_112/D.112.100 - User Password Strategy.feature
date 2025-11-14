
Feature: D.112.100 - The system shall support the ability to send password over emails when a user is created, or password is changed.

    As a REDCap end user
    I want to see that User Password Strategy is functioning as expected

    Scenario: User Password Strategy (created, reset and changed)
        Given I login to REDCap with the user "Test_Admin"   
        And I click on the link labeled "Control Center"
        # EMAIL ADDRESS SET FOR REDCAP ADMIN - without it, emails are not send out from system
        When I click on the link labeled "General Configuration"
        Then I should see "General Configuration"
        When I enter "redcap@test.instance" into the input field labeled "Email Address of REDCap Administrator"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed"
        
        Given I click on the link labeled "Add Users (Table-based Only)"
        Then I should see "User Management for Table-based Authentication" 
        When I enter "Test_User5" into the input field labeled "Username:" 
        And I enter "Test" into the input field labeled "First name:"
        And I enter "User5" into the input field labeled "Last name:"
        And I enter "Test_User5@example.com" into the input field labeled "Primary email:"
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."      
        And I should see "User has been successfully saved. An email with login information was sent to: Test_User5@example.com"   
        And I logout

        ##VERIFY: Verify email in MailHog and set password
        Given I open Email
        Then I should see an email for user "Test_User5@example.com" with subject "REDCap access granted"
        When I click on the link in the email for user "Test_User5@example.com" with subject "REDCap access granted"
        Then I should see "Set Your Password"
        Then I enter "Testing123" into the input field labeled "Password"
        And I enter "Testing123" into the input field labeled "Re-type password"
        And I click on the button labeled "Submit"

       ##VERIFY: Testing New Password
        Given I visit the REDCap login page
        And I enter "Test_User5" into the input field labeled "Username"
        And I enter "Testing123" into the input field labeled "Password"
        And I click on the button labeled "Log In"
        Then I should see "Welcome to REDCap!"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Reset Password 
        Given I click on the link labeled "Profile"
        Then I click on the button labeled "Reset password"
        And I click on the button labeled "Reset" in the dialog box
        Then I should see "Set Your Password"
        Then I enter "Testingpass123" into the input field labeled "Password"
        And I enter "Testingpass123" into the input field labeled "Re-type password"
        And I click on the button labeled "Submit"
        And I logout

        ##VERIFY: Testing New Password
        Given I visit the REDCap login page
        And I enter "Test_User5" into the input field labeled "Username"
        And I enter "Testingpass123" into the input field labeled "Password"
        And I click on the button labeled "Log In"
        Then I should see "Welcome to REDCap!"
        And I logout

        ##ACTION: Forgot Your Password
        Given I visit the REDCap login page
        When I click on the link labeled "Forgot your password"
        Then I should see "REDCap Password Recovery"
        And I enter "Test_User5" into the input field labeled "Username"
        And I click on the button containing "Send password reset email"
        Then I should see "EMAIL SENT!"
        # Then I click on the button labeled "Go back to Login page"

        ##VERIFY: Verify email in MailHog and set password
        Given I open Email
        When I click on the link in the email for user "Test_User5@example.com" with subject "REDCap password reset"
        Then I should see "Set Your Password"
        And I enter "Testing1234" into the input field labeled "Password"
        And I enter "Testing1234" into the input field labeled "Re-type password"
        And I click on the button labeled "Submit"

        ##VERIFY: Testing New Password
        Given I visit the REDCap login page
        When I enter "Test_User5" into the input field labeled "Username"
        And I enter "Testing1234" into the input field labeled "Password"
        And I click on the button labeled "Log In"
        Then I should see "Welcome to REDCap!"
        And I logout