
Feature: D.115.700 - The system shall support the ability to download the PDF of data of all instruments/events in a compact mode (fields with data only) of all records

  As a REDCap end user
  I want to be able to download the PDF of data of all instruments/events (compact mode) of all records

  Scenario: Download PDF of data of all instruments/events (compact mode) of all records
    Given I login to REDCap with the user "Test_User1"
    Then I create a new project named "D.115.700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I enter "Dave" into the data entry form field labeled "Name"
    Then I enter "dave@abc.com" into the data entry form field labeled "Email"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

    Given I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Add new record for this arm"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 2"
    And I enter "Paul" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 2 successfully added."

    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the tab labeled "Other Export Options"
    When I click on the icon Compact PDF to download PDF of data collection instruments containing saved data 
    Then I should see a downloaded file named "D115700_yyyy_mm_dd_hhmm.pdf"
    And I should see the following values in the downloaded PDF
      |                                  |      D.115.700                |
      |                                  |      Record ID 1 (Event 1)    |
      | Text Validation                  |                               |
      | Record ID                        |       1                       |
      | Name                             |       Dave                    |
      | Email                            |       dave@abc.com            |
      |                                  |     Record ID 1 (Event 1)     | 
      | Data Types                       |                               |
      | Calculated Field                 |         6                     |
      | Section Break                    |                               |
      | Descriptive Text with File       |                               |
      | [Attachment: "7_image_v913.jpg"] |                               |
      | Section Break                    |                               |
      | Descriptive Text                 |                               |
      |                                  |      Record ID 2 (Event 1)    |
      | Text Validation                  |                               |
      | Record ID                        |       2                       |
      | Name                             |       Paul                    |

    # Checking for Identifier field twice doesn't work as expected in ATS as it might just check the first Identifier row for all the 2 entries. 
    # But keeping it for manual testing.
    # Not verifying Name field in Data Types in Record ID 1 (Event 1) and Email field in Text Validation in Record ID 2 (Event 1) as ATS will fail. 
    # Name is present with values of Dave and Paul in PDF
    And I should NOT see the following values in the downloaded PDF
      | Text2                            |
      | Text Box                         |
      | Notes Box                        |
      | Multiple Choice Dropdown Auto    |
      | Multiple Choice Dropdown Manual  |
      | Radio Button Auto                |
      | Radio Button Manual              |
      | Checkbox                         |
      | Signature                        |
      | File Upload                      |
      | Required                         |
      | Identifier                       |
      | Identifier                       |
      | Edit Field                       |
      
    #VERIFY_LOG
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported            |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Download all data entry forms as PDF (all records) |