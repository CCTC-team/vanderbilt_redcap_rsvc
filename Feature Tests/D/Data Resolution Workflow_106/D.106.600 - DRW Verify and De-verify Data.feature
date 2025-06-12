Feature: D.106.600 Data Resolution Workflow

  As a REDCap end user
  I want to see that I have the ability to verify and de-verify data value based on user rights
  I want to see that I have the ability to automatically de-verify data that has been verified and subsequently changed 

  Scenario: D.106.600 - Verify and de-verify data
      Given I login to REDCap with the user "Test_User1" 
      And I create a new project named "D.106.600" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

      #ACTION: Enable the Data Resolution Workflow (Data Queries)
      Given I click on the link labeled "Project Setup"
      And I click on the button labeled "Additional customizations"
      And I select "Data Resolution Workflow" in the dropdown field labeled "Enable:"
      Then I click on the button labeled "Save"
      Then I should see "The Data Resolution Workflow has now been enabled!"
      And I click on the button labeled "Close" in the dialog box

     #ACTION: Import data 
      Given I click on the link labeled "Data Import Tool"
      And  I upload a "csv" format file located at "import_files/redcap_val/redcap_val_Data_Import.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
      And I should see "Your document was uploaded successfully and is ready for review."
      And I click on the button labeled "Import Data"
      Then I should see "Import Successful!"

      #ACTION: Edit User rights to verify/de-verify data
      Given I click on the link labeled "User Rights"
      And I click on the link labeled "test_user1"
      And I click on the button labeled "Edit user privileges"
      And I select the User Right named Data Resolution Workflow and choose Open, close, and respond to queries
      And I click on the button labeled "Save Changes"
      Then I should see 'User "test_user1" was successfully edited'

      #ACTION: Verify and de-verify data
      Given I click on the link labeled "Record Status Dashboard"
      When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
      And I click on the Comment icon for the field labeled "Name"
      Then I should see "Data Resolution Workflow" in the dialog box
      And I should see a table header and row containing the following values in a table:
            | Date / Time      | User       | Comments and Details                           | 
            | mm/dd/yyyy hh:mm | test_user1 | Data Changes Made: ptname_v2_v2 = 'Tony Stone' |

      When I select the radio option Verified data value in Data Resolution Workflow
      And I enter "Test Verify Data" in the comment box in Data Resolution Workflow
      And I click on the button labeled "Verified data value" in the dialog box
      Then I should see a Tick icon for the field labeled "Name"
      
      Given I click on the link labeled "Resolve Issues"
      And I select the option "All status types (1)" from the dropdown field for Status in Data Resolution Dashboard
      Then I should see a table row containing the following values in a table:
            | 1                      | ptname_v2_v2 | Test_User1 | Test_User1         | [same as first update] |
            | Event 1 (Arm 1: Arm 1) | (Name)       | Test_User1 | "Test Verify Data" | [same as first update] |

      Given I click on the link labeled "Record Status Dashboard"
      When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
      And I click on the Tick icon for the field labeled "Name"
      Then I should see "Data Resolution Workflow" in the dialog box
      And I should see a table header and rows containing the following values in a table:
            | Date / Time      | User       | Comments and Details                                  | 
            | mm/dd/yyyy hh:mm | test_user1 | Data Changes Made: ptname_v2_v2 = 'Tony Stone'        |
            | mm/dd/yyyy hh:mm | Test_User1 | Action:Verified data value Comment:“Test Verify Data” |
      
      When I select the radio option De-verify data value in Data Resolution Workflow
      And I click on the button labeled "De-verify data value" in the dialog box
      Then I should see a dialog containing the following text: "A comment is required. Please enter a comment." 
      And I click on the button labeled "Close" in the dialog box
      And I enter "Test De-verify Data" in the comment box in Data Resolution Workflow
      And I click on the button labeled "De-verify data value" in the dialog box
      Then I should see an Exclamation icon for the field labeled "Name"
      And I wait for 1 second
      When I click on the Exclamation icon for the field labeled "Name"
      Then I should see "Data Resolution Workflow" in the dialog box
      And I should see a table header and rows containing the following values in a table:
            | Date / Time      | User       | Comments and Details                                        | 
            | mm/dd/yyyy hh:mm | test_user1 | Data Changes Made: ptname_v2_v2 = 'Tony Stone'              |
            | mm/dd/yyyy hh:mm | Test_User1 | Action:Verified data value Comment:“Test Verify Data”       |
            | mm/dd/yyyy hh:mm | Test_User1 | Action:De-verified data value Comment:“Test De-verify Data” |
      
      And I click on the button labeled "Cancel" in the dialog box

      Given I click on the link labeled "Resolve Issues"
      And I select the option "All status types (1)" from the dropdown field for Status in Data Resolution Dashboard
      Then I should see a table rows containing the following values in a table:
            | 1                      | ptname_v2_v2 | Test_User1 | Test_User1         | Test_User1            |
            | Event 1 (Arm 1: Arm 1) | (Name)       | Test_User1 | "Test Verify Data" | "Test De-verify Data" |

  Scenario: D.106.700 - Automatically De-verify data when verified data is changed
      Given I click on the link labeled "Record Status Dashboard"
      When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
      And I click on the Exclamation icon for the field labeled "Name"
      Then I should see "Data Resolution Workflow" in the dialog box
      And I should see "Data De-verified"
      When I select the radio option Verified data value in Data Resolution Workflow
      And I click on the button labeled "Verified data value" in the dialog box
      Then I should NOT see "Data Resolution Workflow"
      Then I should see a Tick icon for the field labeled "Name"
      Given I clear field and enter "John" into the input field labeled "Name" 
      And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
      Then I should see an Exclamation icon for the field labeled "Name"
      And I click on the Exclamation icon for the field labeled "Name"
      Then I should see "Data Resolution Workflow" in the dialog box
      And I should see a table header and rows containing the following values in a table:
            | Date / Time      | User       | Comments and Details                                          | 
            | mm/dd/yyyy hh:mm | test_user1 | Data Changes Made: ptname_v2_v2 = 'John'                      |
            | mm/dd/yyyy hh:mm | Test_User1 | Action:De-verified data value (automatically via data change) |

      And I click on the button labeled "Cancel" in the dialog box

      ##VERIFY_LOG
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action                                   | List of Data Changes OR Fields Exported                                                                                |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design                            | De-verified data value (Record: 1, Event: Event 1 (Arm 1: Arm 1), Field: ptname_v2_v2)                                 |
      | mm/dd/yyyy hh:mm | test_user1 | Update record 1 (Event 1 (Arm 1: Arm 1)) | ptname_v2_v2 = 'John'                                                                                                  |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design                            | Verified data value (Record: 1, Event: Event 1 (Arm 1: Arm 1), Field: ptname_v2_v2)                                    |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design                            | De-verified data value (Record: 1, Event: Event 1 (Arm 1: Arm 1), Field: ptname_v2_v2, Comment: "Test De-verify Data") |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design                            | Verified data value (Record: 1, Event: Event 1 (Arm 1: Arm 1), Field: ptname_v2_v2, Comment: "Test Verify Data")       |

      And I logout