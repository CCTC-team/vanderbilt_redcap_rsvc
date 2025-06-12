
Feature: D.117.100 - The system shall support the ability to enable/disable File Version History for 'File Upload' fields 

  As a REDCap end user
  I want to see that File Version History for File Upload fields is functioning as expected

  Scenario: D.117.100 - File Version History Enabled
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "D.117.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button
    And I click on the button labeled "Additional customizations"
    And I should see a checkbox labeled Enable the Data History popup for all data collection instruments that is checked in additional customizations
    And I should see a checkbox labeled Enable the File Version History for 'File Upload' fields that is checked in additional customizations
    When I click on the button labeled "Cancel"

    Given I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Add new record for this arm"
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/redcap_val/file1.csv", by clicking the button near "Select a file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see a link labeled "file1.csv (0.01 MB)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    When I download a file by clicking on the link labeled "file1.csv (0.01 MB)"
    Then I should see a downloaded file named "file1.csv"

    Given I click on the History icon for the field labeled "File Upload"
    Then I should see 'Data History for variable "file_upload" for record "2"'
    And I should see a table header and rows containing the following values in a table:
      | User       | File Uploaded             | File Version   |
      | test_user1 | Upload File - "file1.csv" | V1             |
      
    And I should see a link labeled "Delete" in the dialog box
    And I should see a button labeled "Download" in the dialog box
    And I click on the button labeled "Close" in the dialog box
    
  Scenario: D.117.200 - Upload new version of file
    Given I click on the link labeled "Upload new version"
    And I upload a "csv" format file located at "import_files/B3161200100_ACCURATE.csv", by clicking the button near "File Upload" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see a link labeled "B3161200100_ACCURATE.csv (0.01 MB)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    When I download a file by clicking on the link labeled "B3161200100_ACCURATE.csv (0.01 MB)"
    Then I should see a downloaded file named "B3161200100_ACCURATE.csv"

    # D.117.300
    Given I click on the History icon for the field labeled "File Upload"
    Then I should see 'Data History for variable "file_upload" for record "2"'
    And I should see a table header and rows containing the following values in a table:
      | User       | File Uploaded                            | File Version   |
      | test_user1 | Upload File - "file1.csv"                | V1             |
      | test_user1 | Upload File - "B3161200100_ACCURATE.csv" | V2             |
    
    And I click on the button labeled "Download" for row 1
    And I should see a downloaded file named "file1 (1).csv"
    And I click on the button labeled "Download" for row 2
    And I should see a downloaded file named "B3161200100_ACCURATE (1).csv"
    And I click on the button labeled "Close" in the dialog box

  Scenario: D.117.400 - Download only current version of file during download of zip file
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled exactly "2"
    And I click on the button labeled "Choose action for record"
    And I click on the link labeled "Download ZIP file of all uploaded documents"
    And I wait for 1 second
    Then I should see a downloaded file named "Files_D117100_yyyy-mm-dd_hhmm.zip"
    And I unzip the latest downloaded zip file
    Then the downloaded CSV with filename "unzipped/Files_D117100_yyyy-mm-dd_hhmm/documents/2_event_1_arm_1_data_types_1_file_upload.csv" has the header below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | name | email | text_validation_complete |

    Given I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Add new record for this arm"
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/redcap_val/file1.csv", by clicking the button near "Select a file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see a link labeled "file1.csv (0.01 MB)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    When I download a file by clicking on the link labeled "file1.csv (0.01 MB)"
    Then I should see a downloaded file named "file1 (2).csv"

    When I click on the History icon for the field labeled "File Upload"
    Then I should see 'Data History for variable "file_upload" for record "3"'
    And I should see a table header and rows containing the following values in a table:
      | User       | File Uploaded             | File Version   |
      | test_user1 | Upload File - "file1.csv" | V1             |
   
    And I click on the button labeled "Close" in the dialog box

    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the tab labeled "Other Export Options"
    When I click on the icon ZIP to download ZIP file of uploaded files
    And I wait for 1 second
    Then I should see a downloaded file named "Files_D117100_yyyy-mm-dd_hhmm.zip"
    When I unzip the latest downloaded zip file
    Then the downloaded CSV with filename "unzipped/Files_D117100_yyyy-mm-dd_hhmm/documents/2_event_1_arm_1_data_types_1_file_upload.csv" has the header below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | name | email | text_validation_complete |
    
    And the downloaded CSV with filename "unzipped/Files_D117100_yyyy-mm-dd_hhmm/documents/3_event_1_arm_1_data_types_1_file_upload.csv" has the header below
      | record_id | redcap_event_name | redcap_survey_identifier | lname | fname | email | demographics |survey_timestamp | reminder | description | survey_complete |

    Given I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled exactly "2"
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I click on the History icon for the field labeled "File Upload"
    Then I should see 'Data History for variable "file_upload" for record "2"'
    And I click on the link labeled "Delete" for row 1
    When I click on the button labeled "Yes, delete it"
    Then I should see "Deleted on"
    And I should see a table header and rows containing the following values in a table:
      | User       | File Uploaded                            | File Version   | Information / Action        |
      | test_user1 | Upload File - "file1.csv"                | V1             |                             |
      | test_user1 | Upload File - "B3161200100_ACCURATE.csv" | V2             |                             |
    
    And I click on the button labeled "Close" in the dialog box
    When I click on the link labeled "Remove file"
    Then I click on the button labeled "Yes, delete it"
    Then I should see a link labeled "Upload file"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    When I click on the History icon for the field labeled "File Upload"
    Then I should see 'Data History for variable "file_upload" for record "2"'
    Then I should see a table header and rows containing the following values in a table:
      | User       | File Uploaded                            | File Version   | Information / Action        |
      | test_user1 | Upload File - "file1.csv"                | V1             | Deleted on                  |
      | test_user1 | Upload File - "B3161200100_ACCURATE.csv" | V2             | Deleted on                  |
    
    And I click on the button labeled "Close" in the dialog box

    # Disable File Version History
    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Additional customizations"
    Then I uncheck the checkbox labeled Enable the File Version History for 'File Upload' fields in additional customizations
    And I click on the button labeled "Save"

    Given I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Add new record for this arm"
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/redcap_val/file1.csv", by clicking the button near "Select a file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see a link labeled "file1.csv (0.01 MB)"
    
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should NOT see a link labeled "Upload new version"
    And I click on the link labeled "Remove file"
    And I click on the button labeled "Yes, delete it"
    Then I should see a link labeled "Upload file"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    When I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/redcap_val/file1.csv", by clicking the button near "Select a file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see a link labeled "file1.csv (0.01 MB)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

    # Verify file version is not saved
    Given I click on the History icon for the field labeled "File Upload"
    When I should see 'Data History for variable "file_upload" for record "4"'
    Then I should see a table header and rows containing the following values in a table:
      | User       | Data Changes Made         |
      | test_user1 | Upload File - "file1.csv" | 
      | test_user1 | Delete File               |
      | test_user1 | Upload File - "file1.csv" | 

    And I click on the button labeled "Close" in the dialog box

    #VERIFY_LOG
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action                                                    | List of Data Changes OR Fields Exported                                              |
      | mm/dd/yyyy hh:mm | test_user1 | Update record 4 (Event 1 (Arm 1: Arm 1))                  | file_upload = '6'                                                                    |
      | mm/dd/yyyy hh:mm | test_user1 | Update record 4 (Event 1 (Arm 1: Arm 1))                  | file_upload = ''                                                                     |
      | mm/dd/yyyy hh:mm | test_user1 | Create record 4 (Event 1 (Arm 1: Arm 1))                  | calculated_field = '6', file_upload = '5' data_types_complete = '0', record_id = '4' |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design                                             | Make project customizations                                                          |
      | mm/dd/yyyy hh:mm | test_user1 | Update record 2 (Event 1 (Arm 1: Arm 1))                  | file_upload = ''                                                                     |
      | mm/dd/yyyy hh:mm | test_user1 | Deleted Document Update record 2 (Event 1 (Arm 1: Arm 1)) | file_upload (V1)                                                                     |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design                                             | Download ZIP of uploaded files (all records)                                         |
      | mm/dd/yyyy hh:mm | test_user1 | Download uploaded document Record 3                       | file_upload                                                                          |
      | mm/dd/yyyy hh:mm | test_user1 | Create record 3 (Event 1 (Arm 1: Arm 1))                  | calculated_field = '6', file_upload = '4' data_types_complete = '0', record_id = '3' |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design                                             | Download ZIP of uploaded files (single record)                                       |
      | mm/dd/yyyy hh:mm | test_user1 | Download uploaded document Record 2                       | file_upload (V2)                                                                     |
      | mm/dd/yyyy hh:mm | test_user1 | Download uploaded document Record 2                       | file_upload (V1)                                                                     |
      | mm/dd/yyyy hh:mm | test_user1 | Download uploaded document Record 2                       | file_upload                                                                          |
      | mm/dd/yyyy hh:mm | test_user1 | Update record 2 (Event 1 (Arm 1: Arm 1))                  | file_upload = '3'                                                                    |
      | mm/dd/yyyy hh:mm | test_user1 | Download uploaded document Record 2                       | file_upload                                                                          |
      | mm/dd/yyyy hh:mm | test_user1 | Create record 2 (Event 1 (Arm 1: Arm 1))                  | calculated_field = '6', file_upload = '2' data_types_complete = '0', record_id = '2' |

    And I logout