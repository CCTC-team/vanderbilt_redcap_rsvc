Feature: D.119.200 Downloading Metadata and data - The system shall support the ability to download metadata and data (XML)

  As a REDCap end user
  I want to see that downloading metadata and data feature is functioning as expected
    
  Scenario: Scenario: 1 D.119.200 - Download metadata & data(XML) consisting Text Validation(Record ID,Name, Email, Form status) and Data Types(Name, Text2, Textbox, Notes Box, Calculated Field, Multiple choice dropdown Auto, Multiple choice dropdown Manual, Radio Button Manual, Checkbox, Signature (add signature), File Upload (file_upload), Section break, Descriptive Text with File,Identifier,Identifier, Edit Field, Section break, Descriptive Text, Form Status) as instruments shown in Online Designer. All records, User roles, Data Access Group and Data Quality to be included in XML.
    Given I login to REDCap with the user "Test_User1"   
    And I create a new project named "D.119.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    #ACTION: Import data 
    Given I click on the link labeled "Data Import Tool"
    And  I upload a "csv" format file located at "import_files/redcap_val/D.119.100_Data_Import.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I should see "Your document was uploaded successfully and is ready for review."
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"

    #VERIFY_RSD: 2 records
    When I click on the link labeled "Record Status Dashboard"
    And I should see a table header and rows containing the following values in a table: 
    | Record ID |
    | 1         |
    | 2         |      

    #ACTION: Download Metadata and data xml file for project D.119.200
    Given I click on the link labeled "Project Setup"
    Then I click on the link labeled "Other Functionality"
    And I click on the button labeled "Download metadata & data (XML)"
    Then I should see a dialog containing the following text: 'Exporting "Entire project (metadata & data)"' 
    And I click on the button labeled "Export Entire Project (metadata & data)" in the dialog box
    Then I should see a dialog containing the following text: "Data export was successful!"
    And I click on the icon REDCap XML to download REDCap Project (XML)
    And I click on the button labeled "Close" in the dialog box
  
    #FUNCTIONAL_REQUIREMENT
    #ACTION: Create new Project using downloaded metadata and data file and verify
    Given I click on the link labeled "My Projects"
    And I create a new project named "D.119.200_Metadata_and_Data" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing the latest downloaded CDISC file, and clicking the "Create Project" button

    #VERIFY: Project settings
    When I click on the link labeled "Project Setup"
    And I should see the button labeled "Enable" in the "Use surveys in this project?" row in the "Main project settings" section
    And I should see the button labeled "Disable" in the "Use longitudinal data collection with defined events?" row in the "Main project settings" section
    
    #VERIFY: Instruments
    When I click on the button labeled "Online Designer" 
    Then I should see a table header and rows containing the following values in a table:
      | Instrument name          | Fields |
      | Text Validation          | 3      |
      | Data Types               | 18     |

    #VERIFY: Events and Arms 
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    Then I see "Arm 1"
    And I should see a table header and rows containing the following values in the define events table:
      | Event # | Event Label | Unique event name (auto generated) [event-name] |
      | 1       | Event 1     | event_1_arm_1                                   |
      | 2       | Event 2     | event_2_arm_1                                   |
      | 3       | Event Three | event_three_arm_1                               |

    Then I click on the tab labeled "Arm Two" 
    And I should see a table header and rows containing the following values in the define events table:
      | Event # | Event Label | Unique event name (auto generated) [event-name] |
      | 1       | Event 1     | event_1_arm_2                                   |
    
    Then I click on the tab labeled "Designate Instruments for My Events"
    And I click on the tab labeled "Arm 1" 
    And I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event 1"  
    And I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 1" 
    Then I click on the tab labeled "Arm Two" 
    And I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 1" 

    #VERIFY: Enable optional modules and customizations
    Given I click on the link labeled "Project Setup"
    Then I see the button labeled "Modify" in the "Repeating instruments and events" row in the "Enable optional modules and customizations" section
    And I should see the button labeled "Disable" in the "Auto-numbering for records" row in the "Enable optional modules and customizations" section
    And I should see the button labeled "Enable" in the "Scheduling module" row in the "Enable optional modules and customizations" section
    And I should see the button labeled "Enable" in the "Randomization module" row in the "Enable optional modules and customizations" section
    And I should see the button labeled "Enable" in the "Designate an email field for communications (including survey invitations and alerts)" row in the "Enable optional modules and customizations" section 
    And I should see the button labeled "Enable" in the "Twilio SMS and Voice Call services for surveys and alerts" row in the "Enable optional modules and customizations" section
    And I should see the button labeled "Enable" in the "Mosio SMS services for surveys and alerts" row in the "Enable optional modules and customizations" section
    And I should see the button labeled "Enable" in the "SendGrid Template email services for Alerts & Notifications" row in the "Enable optional modules and customizations" section

    #VERIFY: Additional customizations
    When I click on the button labeled "Additional customizations"
    And I should see a checkbox labeled "Enable the Field Comment Log or Data Resolution Workflow (Data Queries)?" that is checked
    And I should see a checkbox labeled "Set a Custom Record Label" that is unchecked
    And I should see a checkbox labeled "Designate a Secondary Unique Field" that is unchecked
    And I should see a checkbox labeled "Order the records by another field" that is unchecked
    And I should see a checkbox labeled "Enable the Field Comment Log or Data Resolution Workflow (Data Queries)" that is checked
    And I should see the dropdown field labeled "Enable:" with the option "Field Comment Log" selected
    And I should see a checkbox labeled "Allow users to edit or delete Field Comments (excludes Data Resolution Workflow comments)?" that is checked
    And I should see a checkbox labeled "PDF Customizations" that is unchecked
    And I should see a checkbox labeled "Enable the Data History popup for all data collection instruments?" that is checked
    And I should see a checkbox labeled "Enable the File Version History for 'File Upload' fields?" that is checked
    And I should see a checkbox labeled "Display the Today/Now button for all date and time fields on forms/surveys?" that is checked
    And I should see a checkbox labeled "Prevent branching logic from hiding fields that have values" that is unchecked
    And I should see a checkbox labeled "Require a 'reason' when making changes to existing records?" that is unchecked
    And I should see a checkbox labeled "Protected Email Mode" that is unchecked
    And I should see a checkbox labeled "Data Entry Trigger" that is unchecked
    And I click on the button labeled "Cancel" in the dialog box

    #VERIFY: Data Quality
    When I click on the link labeled "Data Quality"
    Then I should see "Data Quality Rules"
    And I should see a table header and rows containing the following values in a table: 
      | Rule # |                   Rule Name                         | Rule Logic (Show discrepancy  only if...) |        
      | A      | Blank values*                                       |  -                                        |  
      | B      | Blank values* (required fields only)                |  -                                        |  
      | C      | Field validation errors (incorrect data type)       |  -                                        |  
      | D      | Field validation errors (out of range)              |  -                                        |  
      | E      | Outliers for numerical fields                       |  -                                        |
      | E      | (numbers, integers, sliders, calc fields)**         |  -                                        |  
      | F      | Hidden fields that contain values***                |  -                                        |  
      | G      | Multiple choice fields with invalid values          |  -                                        |  
      | H      | Incorrect values for calculated fields              |  -                                        |  
      | I      | Fields containing "missing data codes"              |  -                                        |  
      | 1      | Identifier more than 8                              |  [identifier] > 8			                    |  

    #VERIFY: User Rights
    When I click on the link labeled "User Rights"
    And I click on the link labeled "test_user1"
    And I click on the button labeled "Edit user privileges" on the tooltip
    Then I should see a dialog containing the following text: "Editing existing user"
    And I should see the Data Viewing Rights of the instrument "Text Validation" with option View & Edit selected
    And I should see the Data Viewing Rights of the instrument "Data Types" with option View & Edit selected
    And I should see the Data Export Rights of the instrument "Text Validation" with option Full Data Set selected
    And I should see the Data Export Rights of the instrument "Data Types" with option Full Data Set selected
  
    And I should see a checkbox labeled "Project Design and Setup" that is checked
    And I should see a checkbox labeled "User Rights" that is checked
    And I should see a checkbox labeled "Data Access Groups" that is checked
    And I should see a checkbox labeled "Alerts & Notifications" that is checked
    And I should see a checkbox labeled "Calendar" that is checked
    And I should see a checkbox labeled "Add/Edit/Organize Reports" that is checked
    And I should see a checkbox labeled "Stats & Charts" that is checked
    And I should see a checkbox labeled "Data Import Tool" that is checked
    And I should see a checkbox labeled "Data Comparison Tool" that is checked
    And I should see a checkbox labeled "Logging" that is checked
    And I should see a checkbox labeled "File Repository" that is checked
    And I should see a checkbox labeled "Create & edit rules" that is checked
    And I should see a checkbox labeled "Execute rules" that is checked
    And I should see a checkbox labeled "API Export" that is unchecked
    And I should see a checkbox labeled "API Import/Update" that is unchecked
    And I should see a checkbox labeled "Allows user to collect data offline in the mobile app" that is checked
    And I should see a checkbox labeled "Allow user to download data for all records to the app?" that is checked
    And I should see a checkbox labeled "Create Records" that is checked
    And I should see a checkbox labeled "Rename Records" that is unchecked
    And I should see a checkbox labeled "Delete Records" that is unchecked
    And I should see a checkbox labeled "Record Locking Customization" that is unchecked
    And I should see a radio labeled "Disabled" that is checked
    And I should see a checkbox labeled "Lock/Unlock *Entire* Records (record level)" that is unchecked
    And I click on the button labeled "Cancel"

    #VERIFY: DAGS
    When I click on the link labeled "DAGs"
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups        | Users in group                                 | Number of records in group | Unique group name (auto generated) | Group ID number |
      | DAG1                      |                                                |          0                 | dag1                               | 2               |  
      | [Not assigned to a group] | test_user1 (Test User1) * Can view ALL records |                            |                                    |                 |
    
    #VERIFY: Codebook - Instruments and Fields
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:  
      | #  | Variabl / Field Name                        | Field Label                                               | Field Attributes (Field Type, Validation, Choices, Calculations, etc.) | 
      |    | Instrument: Text Validation (text_validation)|                                                           |                                                                        |   
      | 1  | [record_id]                                  | Record ID                                                 | text                                                                   |  
      | 2  | [ptname_v2_v2]                               | Name                                                      | text                                                                   |  
      | 3  | [email_v2]                                   | Email                                                     | text (email)                                                           |  
      | 4  | [text_validation_complete]                   | Section Header: Form Status Complete?                     | dropdown                                                               | 
      | 4  | [text_validation_complete]                   | Section Header: Form Status Complete?                     | 0 Incomplete                                                           | 
      | 4  | [text_validation_complete]                   | Section Header: Form Status Complete?                     | 1 Unverified                                                           | 
      | 4  | [text_validation_complete]                   | Section Header: Form Status Complete?                     | 2 Complete                                                             |  
      |    | Instrument: Data Types (data_types)          |                                                           |                                                                        | 
      | 5  | [ptname]                                     | Name                                                      | text                                                                   | 
      | 6  | [text2]                                      | text2                                                     | text                                                                   |   
      | 7  | [textbox]                                    | Text Box                                                  | text                                                                   |   
      | 8  | [notesbox]                                   | Notes Box                                                 | notes                                                                  | 
      | 9  | [calculated_field]                           | Calculated Field                                          | calc Calculation: 3*2                                                  |
      | 10 | [multiple_dropdown_auto]                     | Multiple Choice Dropdown Auto                             | dropdown                                                               |
      | 10 | [multiple_dropdown_auto]                     | Multiple Choice Dropdown Auto                             | 1 DDChoice1                                                            |
      | 10 | [multiple_dropdown_auto]                     | Multiple Choice Dropdown Auto                             | 1 DDChoice2                                                            |
      | 10 | [multiple_dropdown_auto]                     | Multiple Choice Dropdown Auto                             | 1 DDChoice3                                                            |
      | 11 | [multiple_dropdown_manual]                   | Multiple Choice Dropdown Manual                           | dropdown                                                               |
      | 11 | [multiple_dropdown_manual]                   | Multiple Choice Dropdown Manual                           | 5 DDChoice5                                                            |
      | 11 | [multiple_dropdown_manual]                   | Multiple Choice Dropdown Manual                           | 7 DDChoice6                                                            |
      | 11 | [multiple_dropdown_manual]                   | Multiple Choice Dropdown Manual                           | 6 DDChoice7                                                            |
      | 12 | [radio_button_auto]                          | Radio Button Auto                                         | radio                                                                  |
      | 12 | [radio_button_auto]                          | Radio Button Auto                                         | 1 Choice1                                                              |
      | 12 | [radio_button_auto]                          | Radio Button Auto                                         | 2 Choice2                                                              |
      | 12 | [radio_button_auto]                          | Radio Button Auto                                         | 3 Choice.3                                                              |
      | 13 | [radio_button_manual]                        | Radio Button Manual                                       | radio                                                                  | 
      | 13 | [radio_button_manual]                        | Radio Button Manual                                       | 9..9 Choice99                                                          | 
      | 13 | [radio_button_manual]                        | Radio Button Manual                                       | 100 Choice100                                                          | 
      | 13 | [radio_button_manual]                        | Radio Button Manual                                       | 101 Choice101                                                          | 
      | 14 | [checkbox]                                   | Checkbox                                                  | checkbox                                                               |
      | 14 | [checkbox]                                   | Checkbox                                                  | 1 checkbox___1 Checkbox                                                |
      | 14 | [checkbox]                                   | Checkbox                                                  | 2 checkbox___2 Checkbox2                                               |
      | 14 | [checkbox]                                   | Checkbox                                                  | 3 checkbox___3 Checkbox3                                               |
      | 15 | [signature]                                  | Signature                                                 | file (signature)                                                       |                                            
      | 16 | [file_upload]                                | File Upload                                               | file                                                                   |
      | 17 | [descriptive_file_text]                      | Section Header: Section Break Descriptive Text with File  | descriptive                                                            |
      | 18 | [required]                                   | Required                                                  | text                                                                   |                                                  
      | 19 | [identifier]                                 | Identifier                                                | text, Identifier                                                       |
      | 20 | [identifier_2]                               | Identifier                                                | text, Identifier                                                       |
      | 21 | [edit_field]                                 | Edit Field                                                | text                                                                   |
      | 22 | [descriptive_text]                           | Section Header: Section Break Descriptive Text            | descriptive                                                            |
      | 23 | [data_types_complete]                        | Section Header: Form Status Complete?                     | dropdown                                                               | 
      | 23 | [data_types_complete]                        | Section Header: Form Status Complete?                     | 0 Incomplete                                                           | 
      | 23 | [data_types_complete]                        | Section Header: Form Status Complete?                     | 1 Unverified                                                           | 
      | 23 | [data_types_complete]                        | Section Header: Form Status Complete?                     | 2 Complete                                                             |   
  
    #VERIFY_RSD: Verify Data
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in a table:
      | Record ID |
      | 1         |
      | 2         |      

    
    #VERIFY: Data for Record 1
    Then I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I should see "Tony Stone" in the data entry form field "Name" 
    And I should see "tonystone@example.com" in the data entry form field "Email" 
    And I should see the dropdown field labeled "Complete" with the option "Complete" selected
    Then I click on the link labeled "Data Types" 
    And I should see "Lily Brown" in the data entry form field "Name" 
    And I should see "She is a teacher" in the data entry form field "Text Box"
    And I should see "6" in the data entry form field "Calculated Field"
    And I should see the dropdown field labeled "Multiple Choice Dropdown Manual" with the option "DDChoice5" selected
    And I should see the radio labeled "Radio Button Manual" with option "Choice99" selected
    And I should see a link labeled "7_image_v913.jpg"
    And I should see "1" in the data entry form field "Required"
    And I should see "7" in the data entry form field "Identifier"
    And I should see the dropdown field labeled "Complete" with the option "Incomplete" selected
    
    #VERIFY: Data for Record 2
    Then I click on the link labeled "Record Status Dashboard"
    Then I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "2" and click on the bubble
    And I should see "Daniel Smith" in the data entry form field "Name" 
    And I should see "dannysmith@example.com" in the data entry form field "Email" 
    And I should see the dropdown field labeled "Complete" with the option "Complete" selected
    Then I click on the link labeled "Data Types"
    And I should see "Fred Gatefield" in the data entry form field "Name" 
    And I should see "He is a doctor" in the data entry form field "Text Box"
    And I should see "6" in the data entry form field "Calculated Field"  
    And I should see the dropdown field labeled "Multiple Choice Dropdown Manual" with the option "DDChoice6" selected
    And I should see the radio labeled "Radio Button Manual" with option "Choice101" selected
    And I should see a checkbox labeled "Checkbox" that is checked
    And I should see a link labeled "7_image_v913.jpg"
    And I should see "2" in the data entry form field "Required"
    And I should see "9" in the data entry form field "Identifier"
    And I should see the dropdown field labeled "Complete" with the option "Incomplete" selected
    And I logout