
Feature: Send It: D.105.100 - The system shall support the ability to send a file to user/users.

  As a REDCap end user
  I want to see that Send It is functioning as expected

  Scenario: D.105.100 Send a file to user
    Given I login to REDCap with the user "Test_User1" 
    When I click on the link labeled "Send-It"
    Then I should see the dropdown field labeled "From:" with the option "Test_User1@test.edu" selected
    When I enter "joe@abc.com; paul@abc.com" into the textarea field labeled "To:"
    And I enter "Send-it file" into the input field labeled "Email subject:"
    And I enter "Send-it csv file" into the textarea field labeled "Email message:"
    And I select "2 days" on the dropdown field labeled "Expiration:"
    Then I upload a file located at "/import_files/redcap_val/redcap_val_Data_Import.csv" by clicking on the button labeled "Choose file"
    And I click on the button labeled "Send It!"
    Then I should see "File successfully uploaded!"

    # Download the file
    Given I open Email
    # Two emails sent, each containing a password and a link for the respective user
    Then I should see 2 emails for user "joe@abc.com"
    And I should see 2 emails for user "paul@abc.com"
    When I copy the password for user "joe@abc.com" from the email with subject "Re: [REDCap Send-It] Send-it file"
    And I click on the link in the email for user "joe@abc.com" with subject "[REDCap Send-It] Send-it file"
    And I paste the password into the input field
    When I click on the button labeled "Download File"
    Then I should see "SUCCESS! The file will begin downloading momentarily."
    Then I should see a downloaded file named "redcap_val_Data_Import.csv"
    And I should have the latest downloaded "csv" file that contains the headings below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | ptname_v2_v2 | email_v2 | text_validation_complete | ptname | textbox | multiple_dropdown_manual | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | file_upload | required | data_types_complete |
  
    And I logout