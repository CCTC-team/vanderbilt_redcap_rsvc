Feature: D.5.22.300 - The system shall support the ability to limit fields included in a report.

  As a REDCap end user
  I want to be able to limit fields included in a report. 

  Scenario: D.5.22.300 - Limit Fields in a Report
    Given I login to REDCap with the user "Test_User1"
    Then I create a new project named "D.5.22.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    Given I click on the link labeled "Data Import Tool"
    And  I upload a "csv" format file located at "import_files/redcap_val/redcap_val_Data_Import.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I should see "Your document was uploaded successfully and is ready for review."
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"

    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Create New Report"
    And I enter 'Test Report 1' into the input field labeled "Name of Report:"
    And I enter 'ptname "Name"' into the input field labeled "Field 2"
    And I click on the list item 'ptname "Name"'
    And I enter 'email_v2 "Email"' into the input field labeled "Field 3" 
    And I click on the list item 'email_v2 "Email"'
    And I enter 'required "Required"' into the input field labeled "Field 4" 
    And I click on the list item 'required "Required"'
    Then I should see "Show data for all events or repeating instruments/events for each record returned"
    When I enter 'textbox "Text Box"' into the field label for Filter 1
    And I click on the list item 'textbox "Text Box"'
    And I select the operator "contains" for Filter 1
    And I enter "She" into the operator value for Filter 1
    And I select 'record_id "Record ID"' on the dropdown field labeled "Live Filter 1"
    When I click on the button labeled "Save Report"
    And I click on the button labeled "View report" in the dialog box
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Name        | Email                       | Required |
      | 1         | Event 1 (Arm 1: Arm 1) |                   |                 |             | tonystone@example.com       |          |
      | 1         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Lily Brown  |                             | 1        |
      | 4         | Event 1 (Arm 1: Arm 1) |                   |                 |             | johndoe@example.com         |          |
      | 4         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Shy Green   |                             | 4        |
      | 6         | Event 1 (Arm 1: Arm 1) |                   |                 |             | poppyseven@example.com      |          |
      | 6         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Rose Sally  |                             | 6        |
      | 7         | Event 1 (Arm 1: Arm 1) |                   |                 |             | christopherblue@example.com |          |
      | 7         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Gilly Dilly |                             | 7        |
    
    When I select '7' on the dropdown field labeled "Live filters"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Name        | Email                       | Required |
      | 7         | Event 1 (Arm 1: Arm 1) |                   |                 |             | christopherblue@example.com |          |
      | 7         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Gilly Dilly |                             | 7        |
    
    When I click on the link labeled "Reset"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Name        | Email                       | Required |
      | 1         | Event 1 (Arm 1: Arm 1) |                   |                 |             | tonystone@example.com       |          |
      | 1         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Lily Brown  |                             | 1        |
      | 4         | Event 1 (Arm 1: Arm 1) |                   |                 |             | johndoe@example.com         |          |
      | 4         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Shy Green   |                             | 4        |
      | 6         | Event 1 (Arm 1: Arm 1) |                   |                 |             | poppyseven@example.com      |          |
      | 6         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Rose Sally  |                             | 6        |
      | 7         | Event 1 (Arm 1: Arm 1) |                   |                 |             | christopherblue@example.com |          |
      | 7         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Gilly Dilly |                             | 7        |
    
    When I click on the button labeled "Edit"
    And I enter 'radio_button_manual "Radio Button Manual"' into the field label for Filter 2
    And I click on the list item 'radio_button_manual "Radio Button Manual"'
    And I select the operator "=" for Filter 2
    And I select the operator value "Choice99" for Filter 2
    And I select 'required "Required"' on the dropdown field labeled "First by"
    When I click on the button labeled "Save Report"
    And I click on the button labeled "View report" in the dialog box
    #The order of records does not matter for ATS testing. Hence Step 4 ("First by" filter) should be tested manually
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Name        | Email                       | Required |
      | 1         | Event 1 (Arm 1: Arm 1) |                   |                 |             | tonystone@example.com       |          |
      | 4         | Event 1 (Arm 1: Arm 1) |                   |                 |             | johndoe@example.com         |          |
      | 1         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Lily Brown  |                             | 1        |
      | 4         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Shy Green   |                             | 4        |
    
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    When I click on the button labeled "Edit"
    And I enter 'required "Required"' into the field label for Filter 3
    And I click on the list item 'required "Required"'
    And I select the operator "not =" for Filter 3
    And I enter "4" into the operator value for Filter 3
    When I click on the button labeled "Save Report"
    And I click on the button labeled "View report" in the dialog box
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Name        | Email                       | Required |
      | 1         | Event 1 (Arm 1: Arm 1) |                   |                 |             | tonystone@example.com       |          |
      | 1         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               | Lily Brown  |                             | 1        |
   
    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Designate Instruments for My Events"
    And I click on the tab labeled "Arm 1"
    And I click on the button labeled "Begin Editing"
    And I enable the Data Collection Instrument named "Data Types" for the Event named "Event 2"
    Then I click on the button labeled "Save" on the Designate Instruments for My Events page

    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 2" for record ID "1" and click on the bubble
    And I enter "Jasmine Ryan" into the data entry form field labeled "Name"
    And I enter "9" into the data entry form field labeled "Required"
    And I enter "She is a nurse" into the data entry form field labeled "Text Box"
    Then I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

    Given I click on the link labeled "Data Exports, Reports, and Stats"
    When I click on the button labeled "Edit"
    And I select "Event 2 (Arm 1: Arm 1)" on the multiselect field labeled "Filter by event(s)"
    When I click on the button labeled "Save Report"
    And I click on the button labeled "View report" in the dialog box
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Name         | Email | Required |
      | 1         | Event 2 (Arm 1: Arm 1) |                   | 1               | Jasmine Ryan	|       | 9        |
   
    And I logout