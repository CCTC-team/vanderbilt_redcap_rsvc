Feature: D.113.400 - The system shall support the ability to specify a reason when making changes to existing records 

    As a REDCap end user 
    I want to see that Reason for change is working as expected 
   
    Scenario: D.113.400 - Enable Reason for change 
        Given I login to REDCap with the user "Test_Admin" 
        And I create a new project named "D.113.400" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button
        Given I click on the link labeled "Project Setup"
        And I click on the button labeled "Additional customizations"
        And I check the checkbox labeled Require a 'reason' when making changes to existing records in additional customizations
        Then I click on the button labeled "Save"

        #VERIFY_LOG
        Given I click on the link labeled "Logging"
        Then I should see a table header and row containing the following values in the logging table:
            | Date / Time      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Make project customizations             |

        #ACTION: Import data 
        Given I click on the link labeled "Data Import Tool"
        And  I upload a "csv" format file located at "import_files/redcap_val/redcap_val_Data_Import.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        And I should see "Your document was uploaded successfully and is ready for review."
        And I should see "Please supply a reason for the data changes for EACH existing record in the text boxes."
        And I enter reason for change as "Reason 1" for row 1
        And I enter reason for change as "Reason 2" for row 2
        And I click on the  button labeled "Import Data"
        Then I should see "Import Successful!"

        #ACTION: Change field values
        Given I click on the link labeled "Record Status Dashboard"
        When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
        And I click on the History icon for the field labeled "Name"
        Then I should see a table header and row containing the following values in a table:
            | Date / Time of Change | User       | Data Changes Made | Reason for Data Change(s) | 
            | mm/dd/yyyy hh:mm      | test_admin | Lily Brown        | Reason 2                  |

        And I click on the button labeled "Close" in the dialog box
        And I click on the link labeled "Text Validation"
        When I click on the History icon for the field labeled "Name"
        # Bug - Should be Reason 1 but shows Reason 2
        Then I should see a table header and row containing the following values in a table:
            | Date / Time of Change | User       | Data Changes Made | Reason for Data Change(s) | 
            | mm/dd/yyyy hh:mm      | test_admin | Tony Stone        | Reason 2                  |

        And I click on the button labeled "Close" in the dialog box
        When I clear field and enter "John" into the data entry form field labeled "Name"
        And I clear field and enter "john@email.com" into the data entry form field labeled "Email" 
        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        Then I should see "Please supply reason for data changes" in the dialog box 
        And I enter "Reason 3" into the textarea field labeled "Reason for changes:" in the dialog box
        And I click on the button labeled "Save" in the dialog box

        #ACTION: Verify reason for change history
        When I click on the History icon for the field labeled "Name"
        Then I should see a table header and row containing the following values in a table:
            | Date / Time of Change | User       | Data Changes Made | Reason for Data Change(s) | 
            | mm/dd/yyyy hh:mm      | test_admin | Tony Stone        | Reason 2                  |
            | mm/dd/yyyy hh:mm      | test_admin |  John             | Reason 3                  |

        And I click on the button labeled "Close"
        Given I click on the History icon for the field labeled "Email"
        Then I should see a table header and row containing the following values in a table:
            | Date / Time of Change | User       | Data Changes Made     | Reason for Data Change(s) | 
            | mm/dd/yyyy hh:mm      | test_admin | tonystone@example.com | Reason 2                  |
            | mm/dd/yyyy hh:mm      | test_admin | john@email.com        | Reason 3                  |

        And I click on the button labeled "Close"

    Scenario: Disable Reason for Change
        Given I click on the link labeled "Project Setup"
        And I click on the button labeled "Additional customizations"
        And I uncheck the checkbox labeled Require a 'reason' when making changes to existing records in additional customizations
        Then I click on the button labeled "Save"

        Given I click on the link labeled "Record Status Dashboard"
        When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
        When I clear field and enter "Joe" into the data entry form field labeled "Name"
        And I clear field and enter "joe@email.com" into the data entry form field labeled "Email" 
        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        Then I should NOT see "Please supply reason for data changes"
        And I should see "successfully edited"
        And I logout