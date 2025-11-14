Feature: Send It: D.105.200 - The system shall support the ability to receive email confirmation of file download from the user/users.

  As a REDCap end user
  I want to see that Send It is functioning as expected
  Scenario: Set email address for Redcap Admin
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    # EMAIL ADDRESS SET FOR REDCAP ADMIN - without it, emails are not send out from system
    Given I click on the link labeled "General Configuration"
    Then I should see "General Configuration"
    When I enter "redcap@test.instance" into the input field labeled "Email Address of REDCap Administrator"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"
    Given I logout

  Scenario: D.105.200 - Received Email Confirmation
    Given I login to REDCap with the user "Test_User1" 
    When I click on the link labeled "Send-It"
    Then I should see the dropdown field labeled "From:" with the option "Test_User1@test.edu" selected
    When I enter "dave@abc.com" into the textarea field labeled "To:"
    And I enter "Send-it file" into the input field labeled "Email subject:"
    And I enter "Send-it csv file" into the textarea field labeled "Email message:"
    #The file will expire and become inaccessible after 4 days
    And I select "4 days" on the dropdown field labeled "Expiration:"
    Then I upload a file located at "/import_files/redcap_val/redcap_val_Data_Import.csv" by clicking on the button labeled "Choose file"
    And I check the checkbox labeled "Receive confirmation?"
    And I click on the button labeled "Send It!"
    Then I should see "File successfully uploaded!"
    
    # Download the file
    Given I open Email
    # Two emails sent, each containing a password and a link for the user
    Then I should see 2 emails for user "dave@abc.com"
    And I copy the password for user "dave@abc.com" from the email with subject "Re: [REDCap Send-It] Send-it file"
    And I click on the link in the email for user "dave@abc.com" with subject "[REDCap Send-It] Send-it file"
    Then I paste the password into the input field
    When I click on the button labeled "Download File"
    Then I should see "SUCCESS! The file will begin downloading momentarily."
    And I should see a downloaded file named "redcap_val_Data_Import.csv"
    And I should have the latest downloaded "csv" file that contains the headings below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | ptname_v2_v2 | email_v2 | text_validation_complete | ptname | textbox | multiple_dropdown_manual | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | file_upload | required | data_types_complete |
  
    ##VERIFY: Verify email confirmation is received
    Given I open Email
    Then I should see an email for user "Test_User1@test.edu" with subject "[REDCap Send-It] Confirmation of file download"
    
    # # Step definition for changing the system date is not implemented. Hence the below steps need to be verified manually
    # # D.105.300 - Verify the link expires after Expiration Time (4 days)
    # Given I change the system date by 4 days
    # When I open Email
    # Then I should see an email for user "dave@abc.com" with subject "[REDCap Send-It] Send-it file"
    # And I click on the link in the email for user "dave@abc.com" with subject "[REDCap Send-It] Send-it file"
    # Then I should see "The file has expired."
    And I logout