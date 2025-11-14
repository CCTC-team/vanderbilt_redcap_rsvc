
Feature: D.115.600 - The system shall support the ability to download the PDF of data of all instruments/events of all records

  As a REDCap end user
  I want to be able to download the PDF of data of all instruments/events of all records

  Scenario: Download PDF of data of all instruments/events of all records
    Given I login to REDCap with the user "Test_User1"
    Then I create a new project named "D.115.600" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I enter "Dave" into the data entry form field labeled "Name"
    Then I enter "dave@abc.com" into the data entry form field labeled "Email"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 1 successfully edited."

    Given I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Add new record for this arm"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 2"
    And I enter "Paul" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 2 successfully added."
    
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the tab labeled "Other Export Options"
    When I click on the icon PDF to download PDF of data collection instruments containing saved data
    Then I should see a downloaded file named "D115600_yyyy_mm_dd_hhmm.pdf"
    And I should see the following values in the downloaded PDF
      |                                  |      D.115.600                |
      |                                  |      Record ID 1 (Event 1)    |
      | Text Validation                  |                               |
      | Record ID                        |       1                       |
      | Name                             |       Dave                    |
      | Email                            |       dave@abc.com            |
      |                                  |     Record ID 1 (Event 1)     | 
      | Data Types                       |                               |
      | Name                             |                               |
      | Text2                            |                               |
      | Text Box                         |                               |
      | Notes Box                        |                               |
      | Calculated Field                 |         6                     |
      | Multiple Choice Dropdown Auto    | DDChoice1                     |
      |                                  | DDChoice2                     |
      |                                  | DDChoice3                     |
      | Multiple Choice Dropdown Manual  | DDChoice5                     |
      |                                  | DDChoice6                     |
      |                                  | DDChoice7                     |
      | Radio Button Auto                | Choice1                       |
      |                                  | Choice2                       |
      |                                  | Choice.3                      |
      | Radio Button Manual              | Choice99                      |
      |                                  | Choice100                     |
      |                                  | Choice101                     |
      | Checkbox                         | Checkbox                      |
      |                                  | Checkbox2                     |
      |                                  | Checkbox3                     |
      | Signature                        |                               |
      | File Upload                      |                               |
      | Section Break                    |                               |
      | Descriptive Text with File       |                               |
      | [Attachment: "7_image_v913.jpg"] |                               |
      | Required                         |                               |
      | Identifier                       |                               |
      | Identifier                       |                               |
      | Edit Field                       |                               |
      | Section Break                    |                               |
      | Descriptive Text                 |                               |
      |                                  |      Record ID 2 (Event 1)    |
      | Text Validation                  |                               |
      | Record ID                        |       2                       |
      | Name                             |       Paul                    |
      | Email                            |                               |

    #VERIFY_LOG
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported            |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Download all data entry forms as PDF (all records) |