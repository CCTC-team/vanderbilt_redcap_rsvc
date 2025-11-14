Feature: 
    D.111.100 - The system shall support the ability to autogenerate codebook. The following are checked in codebook: 
        D.111.100.1 - The following are checked for a field in codebook: 
            D.111.100.1.1 - Variable name 
            D.111.100.1.2 - Label 
            D.111.100.1.3 - Type 
            D.111.100.1.4 - Field note
            D.111.100.1.5 - Branching Logic 
            D.111.100.1.6 - Action tag  
            D.111.100.1.7 - Identifier 
            D.111.100.1.8 - Required 
        D.111.100.2 - The following subset of field types are verified 
            D.111.100.2.1 - Textbox with email selected 
            D.111.100.2.2 - Textbox with date format e.g. D-M-Y 
            D.111.100.2.3 - Dropdown 
            D.111.100.2.4 - Radio button 
            D.111.100.2.5 - Checkbox 
            D.111.100.2.6 - Calculated Field 
            D.111.100.2.7 - Descriptive Text (with optional Image/Video/Audio/File Attachment)
    D.111.200 - The system shall support the ability to modify and delete fields, which will subsequently alter the codebook.

    As a REDCap end user
    I want to see that Codebook is functioning as expected

    Scenario: Adding fields and verifying Codebook.

        #SETUP
        Given I login to REDCap with the user "Test_User1"   
        When I click on the link labeled "New Project"
        And I enter "D.111.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"

        ##VERIFY_Codebook 
        When I click on the link labeled "Codebook"
        And I should see a table header and rows containing the following values in the codebook table:  
            | # | Variabl / Field Name        | Field Label                             | Field Attributes (Field Type, Validation, Choices, Calculations, etc.) | 
            |   | Instrument: Form 1 (form_1) |                                         |                                                                        |   
            | 1 | [record_id]                 | Record ID                               | text                                                                   | 
            | 2 | [form_1_complete]           | Section Header: Form Status Complete?   | dropdown                                                               | 
            | 2 | [form_1_complete]           | Section Header: Form Status Complete?   | 0 Incomplete                                                           | 
            | 2 | [form_1_complete]           | Section Header: Form Status Complete?   | 1 Unverified                                                           | 
            | 2 | [form_1_complete]           | Section Header: Form Status Complete?   | 2 Complete                                                             | 
        
        ##ACTION: Rename instrument
        Given I click on the link labeled "Online Designer"
        When I click on the button labeled "Choose action"
        And I click on the link labeled "Rename" in the action popup
        And I clear field and enter "Text Validation" into the field with the placeholder text of "Form 1"
        And I click on the button labeled "Save" to rename an instrument
        Then I should see "Text Validation" 

        ##ACTION: Create new instrument (Data Types)
        #Oddly, we need the space before this button because otherwise we match on "Create snapshot of instruments"
        When I click on the button labeled exactly " Create"
        And I click on the button labeled "Add instrument here"
        Then I should see "New instrument name:"
        When I enter "Data Types" into the input field labeled "New instrument name:" within the data collection instrument list
        And I click on the last button labeled "Create"
        Then I should see "SUCCESS!"
        And I click on the button labeled "Close" in the dialog box
        Then I should see "Data Types"

        ##VERIFY_Codebook 
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:  
            | # | Variabl / Field Name                          | Field Label                             | Field Attributes (Field Type, Validation, Choices, Calculations, etc.) | 
            |   | Instrument: Text Validation (text_validation) |                                         |                                                                        |   
            | 1 | [record_id]                                   | Record ID                               | text                                                                   | 
            | 2 | [text_validation_complete]                    | Section Header: Form Status Complete?   | dropdown                                                               | 
            | 2 | [text_validation_complete]                    | Section Header: Form Status Complete?   | 0 Incomplete                                                           | 
            | 2 | [text_validation_complete]                    | Section Header: Form Status Complete?   | 1 Unverified                                                           | 
            | 2 | [text_validation_complete]                    | Section Header: Form Status Complete?   | 2 Complete                                                             |  
            |   | Instrument: Data Types (data_types)           |                                         |                                                                        |   
            | 3 | [data_types_complete]                         | Section Header: Form Status Complete?   | dropdown                                                               | 
            | 3 | [data_types_complete]                         | Section Header: Form Status Complete?   | 0 Incomplete                                                           | 
            | 3 | [data_types_complete]                         | Section Header: Form Status Complete?   | 1 Unverified                                                           | 
            | 3 | [data_types_complete]                         | Section Header: Form Status Complete?   | 2 Complete                                                             | 

        When I click on the link labeled "Designer"
        Then I should see "Data Collection Instruments"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Create Text Box and Email fields
        When I click on the instrument labeled "Text Validation"
        Then I should see "Record ID" within the field with variable name "record_id"
        And I add a new Text Box field labeled "Patient Name" with variable name "ptname_v2" and click on the "Save" button
        And I click on the last button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "email_v2" into the Variable Name of the open "Add New Field" dialog box
        And I enter "Email" into the Field Label of the open "Add New Field" dialog box
        And I select "Email" on the dropdown field labeled "Validation?"
        And I click on the textarea labeled "Action Tags / Field Annotation"
        And I clear field and enter "@NOMISSING" in the textarea field labeled "Logic Editor" in the dialog box
        And I click on the button labeled "Update & Close Editor"
        And I click on the button labeled "Save" in the dialog box
        When I click on the Branching Logic icon for the variable "email"
        And I click on "'" in the textarea field labeled "Advanced Branching Logic Syntax" in the dialog box
        And I clear field and enter '[ptname_v2] != ""' in the textarea field labeled "Logic Editor" in the dialog box
        And I click on the button labeled "Update & Close Editor" in the dialog box
        And I click on the button labeled "Save" in the dialog box
        Then I should see 'Branching logic: [ptname_v2] != ""' within the field with variable name "email"
    
        ##ACTION: Create Date and Multiple Choice Dropdown fields
        When I click on the button labeled "Next instrument"
        Then I should see "Data Types"
        And I click on the button labeled "Dismiss"
        And I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Date of Trial" into the Field Label of the open "Add New Field" dialog box
        And I enter "date_trial" into the Variable Name of the open "Add New Field" dialog box
        And I select "Date (D-M-Y)" on the dropdown field labeled "Validation?"
        And I enter "01-01-2006" into the input field labeled "Minimum"
        And I enter "today" into the input field labeled "Maximum"
        And I enter "must not be in the future" into the input field labeled "Field Note"
        And I click on the button labeled "Save" in the dialog box
        Then I click on the last button labeled "Add Field"
        And I select "Multiple Choice - Drop-down List (Single Answer)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Multiple Choice Dropdown Manual" into the Field Label of the open "Add New Field" dialog box
        And I enter "multiple_dropdown_manual" into the Variable Name of the open "Add New Field" dialog box
        And I enter Choices of "5, DDChoice5" into the open "Add New Field" dialog box
        And I enter Choices of "7, DDChoice7" into the open "Add New Field" dialog box
        And I enter Choices of "6, DDChoice6" into the open "Add New Field" dialog box
        And I click on the button labeled "Save" in the "Add New Field" dialog box
        Then I should see the dropdown field labeled "Multiple Choice Dropdown Manual" with the options below
            | DDChoice5 |
            | DDChoice7 |
            | DDChoice6 |

        ##ACTION: Create Checkbox and File Upload fields
        When I click on the last button labeled "Add Field"
        And I select "Checkboxes (Multiple Answers)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Checkbox" into the Field Label of the open "Add New Field" dialog box
        And I enter "checkbox" into the Variable Name of the open "Add New Field" dialog box
        And I enter Choices of "1, Checkbox1" into the open "Add New Field" dialog box
        And I enter Choices of "2, Checkbox2" into the open "Add New Field" dialog box
        And I enter Choices of "3, Checkbox3" into the open "Add New Field" dialog box
        And I enter Choices of "4, Checkbox4" into the open "Add New Field" dialog box
        And I click on the button labeled "Save" in the "Add New Field" dialog box
        Then I should see the multiselect field labeled "checkbox" with the options below
            | Checkbox1 |
            | Checkbox2 |
            | Checkbox3 |
            | Checkbox4 |

        When I click on the last button labeled "Add Field"
        And I select "File Upload (for users to upload files)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "File Upload" into the Field Label of the open "Add New Field" dialog box
        And I enter "file_upload" into the Variable Name of the open "Add New Field" dialog box
        And I click on the button labeled "Save" in the "Add New Field" dialog box
        Then I should see the link labeled "Upload file"

        ##ACTION: Create Radio Button and Calculated fields
        When I click on the last button labeled "Add Field"
        And I select "Multiple Choice - Radio Buttons (Single Answer)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Radio Button Manual" into the Field Label of the open "Add New Field" dialog box
        And I enter "radio_button_manual" into the Variable Name of the open "Add New Field" dialog box
        And I enter Choices of "99, Choice99" into the open "Add New Field" dialog box
        And I enter Choices of "100, Choice100" into the open "Add New Field" dialog box
        And I enter Choices of "101, Choice101" into the open "Add New Field" dialog box
        And I click on the button labeled "Save" in the "Add New Field" dialog box
        Then I should see the radio field labeled "Radio Button Manual" with the options below
            | Choice99  |
            | Choice100 |
            | Choice101 |

        When I click on the last button labeled "Add Field"
        And I select "Calculated Field" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Calculated Field" into the Field Label of the open "Add New Field" dialog box
        And I enter "calculated_field" into the Variable Name of the open "Add New Field" dialog box
        And I enter the equation "3*2" into Calculation Equation of the open "Add New Field" dialog box
        And I click on the button labeled "Save" in the "Add New Field" dialog box
        Then I should see a field named "Calculated Field"
        And I should see a link labeled "View equation"

        ##ACTION: Create Descriptive text field
        When I click on the last button labeled "Add Field"
        And I select "Descriptive Text (with optional Image/Video/Audio/File Attachment)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Descriptive Text with File" into the Field Label of the open "Add New Field" dialog box
        And I enter "descriptive_text_file" into the Variable Name of the open "Add New Field" dialog box
        And I click on the link labeled "Upload file" in the dialog box
        And I see a dialog containing the following text: "Attach an image, file, or embedded audio"
        When I upload a "docx" format file located at "import_files/File_upload.docx", by clicking the button near "Select a file then click the 'Upload File' button" to browse for the file, and clicking the button labeled "Upload file" to upload the file
        Then I should see "Document was successfully uploaded!" in the dialog box
        And I click on the button labeled "Close" in the dialog box
        And I click on the button labeled "Save" in the "Add New Field" dialog box
        Then I should see the field labeled "Descriptive Text with File"
        And I should see the link labeled "File_upload.docx"

        ##ACTION: Designating field as identifier
        When I click on the last button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Identifier" into the Field Label of the open "Add New Field" dialog box
        And I enter "identifier_2" into the Variable Name of the open "Add New Field" dialog box
        And I mark the field as an identifier
        And I click on the button labeled "Save"
        Then I should see the field labeled "Identifier"

        ##ACTION Designating field as required
        When I click on the last button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Required" into the Field Label of the open "Add New Field" dialog box
        And I enter "required_2" into the Variable Name of the open "Add New Field" dialog box
        And I mark the field required
        And I click on the button labeled "Save"
        Then I should see "must provide value" within the field with variable name "required_2"

        #FUNCTIONAL_REQUIREMENT
        ##VERIFY_Codebook 
        When I click on the link labeled "Codebook"
        And I should see a table header and rows containing the following values in the codebook table:  
            | #  | Variabl / Field Name                         | Field Label                               | Field Attributes (Field Type, Validation, Choices, Calculations, etc.) | 
            |    | Instrument: Text Validation (text_validation)|                                           |                                                                        |   
            | 1  | [record_id]                                  | Record ID                                 | text                                                                   |  
            | 2  | [ptname_v2]                                  | Patient Name                              | text                                                                   |
            | 3  | [email_v2]                                   | Email                                     | text (email)                                                           |
            | 3  | Show the field ONLY if:[ptname_v2] != ""     | Email                                     | Field Annotation: @NOMISSING                                           |
            | 4  | [text_validation_complete]                   | Section Header: Form Status Complete?     | dropdown                                                               | 
            | 4  | [text_validation_complete]                   | Section Header: Form Status Complete?     | 0 Incomplete                                                           | 
            | 4  | [text_validation_complete]                   | Section Header: Form Status Complete?     | 1 Unverified                                                           | 
            | 4  | [text_validation_complete]                   | Section Header: Form Status Complete?     | 2 Complete                                                             |  
            |    | Instrument: Data Types (data_types)          |                                           |                                                                        | 
            | 5  | [date_trial]                                 | Date of Trial must not be in the future   | text (date_dmy, Min: 2006-01-01, Max: today)                           | 
            | 6  | [multiple_dropdown_manual]                   | Multiple Choice Dropdown Manual           | dropdown                                                               |   
            | 6  | [multiple_dropdown_manual]                   | Multiple Choice Dropdown Manual           | 5 DDChoice5                                                            |   
            | 6  | [multiple_dropdown_manual]                   | Multiple Choice Dropdown Manual           | 6 DDChoice6                                                            |   
            | 6  | [multiple_dropdown_manual]                   | Multiple Choice Dropdown Manual           | 7 DDChoice7                                                            |   
            | 7  | [checkbox]                                   | Checkbox                                  | checkbox                                                               |
            | 7  | [checkbox]                                   | Checkbox                                  | 1 checkbox___1 Checkbox1                                               |
            | 7  | [checkbox]                                   | Checkbox                                  | 2 checkbox___2 Checkbox2                                               |
            | 7  | [checkbox]                                   | Checkbox                                  | 3 checkbox___3 Checkbox3                                               |
            | 7  | [checkbox]                                   | Checkbox                                  | 4 checkbox___4 Checkbox4                                               |
            | 8  | [file_upload]                                | File Upload                               | file                                                                   |  
            | 9  | [radio_button_manual]                        | Radio Button Manual                       | radio                                                                  | 
            | 9  | [radio_button_manual]                        | Radio Button Manual                       | 99 Choice99                                                            | 
            | 9  | [radio_button_manual]                        | Radio Button Manual                       | 100 Choice100                                                          | 
            | 9  | [radio_button_manual]                        | Radio Button Manual                       | 101 Choice101                                                          | 
            | 10 | [calculated_field]                           | Calculated Field                          | calc Calculation: 3*2                                                  |  
            | 11 | [descriptive_text_file]                      | Descriptive Text with File                | descriptive                                                            |
            | 12 | [identifier_2]                               | Identifier                                | text, Identifier                                                       |
            | 13 | [required_2]                                 | Required                                  | text, Required                                                         |
            | 14 | [data_types_complete]                        | Section Header: Form Status Complete?     | dropdown                                                               | 
            | 14 | [data_types_complete]                        | Section Header: Form Status Complete?     | 0 Incomplete                                                           | 
            | 14 | [data_types_complete]                        | Section Header: Form Status Complete?     | 1 Unverified                                                           | 
            | 14 | [data_types_complete]                        | Section Header: Form Status Complete?     | 2 Complete                                                             |   

    Scenario: D.111.200 Modify and delete fields and verify codebook
        When I click on the link labeled "Designer"
        And I click on the instrument labeled "Text Validation"
        And I click on the Edit image for the field named "Patient Name"
        And I enter "Participant Name" into the Field Label of the open "Add New Field" dialog box
        Then I click on the button labeled "Save"
        Then I should see "Participant Name"
        And I click on the Delete Field image for the field named "Email"
        And I click on the button labeled "Delete"

        ##VERIFY_Codebook 
        When I click on the link labeled "Codebook"
        Then I should NOT see "[email_v2]" 
        And I should see a table header and rows containing the following values in the codebook table:
            | #  | Variabl / Field Name                          | Field Label                           | Field Attributes (Field Type, Validation, Choices, Calculations, etc.) | 
            |    | Instrument: Text Validation (text_validation) |                                       |                                                                        |   
            | 1  | [record_id]                                   | Record ID                             | text                                                                   |  
            | 2  | [ptname_v2]                                   | Participant Name                      | text                                                                   |
            | 3  | [text_validation_complete]                    | Section Header: Form Status Complete? | dropdown                                                               | 
            | 3  | [text_validation_complete]                    | Section Header: Form Status Complete? | 0 Incomplete                                                           | 
            | 3  | [text_validation_complete]                    | Section Header: Form Status Complete? | 1 Unverified                                                           | 
            | 3  | [text_validation_complete]                    | Section Header: Form Status Complete? | 2 Complete                                                             |  
              
        And I logout