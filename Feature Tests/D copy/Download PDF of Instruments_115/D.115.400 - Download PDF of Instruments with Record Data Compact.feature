Feature: D.115.400 - The system shall support the ability to download the PDF of record data of all instruments/events in a compact mode (fields with data only) 

  As a REDCap end user
  I want to see that download PDF of record data of all instruments/events (compact) is working as expected

  Scenario: Download  PDF of record data of all instruments/events (compact)
    Given I login to REDCap with the user "Test_User1"
    Then I create a new project named "D.115.400" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Designate Instruments for My Events"
    When I click on the button labeled "Begin Editing"
    And I enable the Data Collection Instrument named "Text Validation" for the Event named "Event 2"
    And I enable the Data Collection Instrument named "Text Validation" for the Event named "Event Three"
    And I click on the button labeled "Save" on the Designate Instruments for My Events page
    Then I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event 2"
    And I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event Three"

    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Text Validation" instrument on event "Event 2" for record ID "1" and click on the bubble
    Then I enter "Joe" into the input field labeled "Name"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

    Given I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event Three"
    Then I enter "John" into the input field labeled "Name"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

    Given I click on the button labeled "Choose action for record"
    And I click on the link labeled "Download PDF of record data for all instruments/events (compact)"
    Then I should see a downloaded file named "D115400_yyyy_mm_dd_hhmm.pdf"
    And I should see the following values in the downloaded PDF
      |                                  |      D.115.400                |
      |                                  |      Record ID 1 (Event 1)    |
      | Text Validation                  |                               |
      | Record ID                        |       1                       |
      |                                  |     Record ID 1 (Event Three) | 
      | Text Validation                  |                               |
      | Record ID                        |       1                       |
      | Name                             |       John                    |
      |                                  |      Record ID 1 (Event 1)    |
      | Data Types                       |                               |
      | Calculated Field                 |      6                        |
      | Section Break                    |                               |
      | Descriptive Text with File       |                               |
      | [Attachment: "7_image_v913.jpg"] |                               |
      | Section Break                    |                               |
      | Descriptive Text                 |                               |
      |                                  |     Record ID 1 (Event 2)     | 
      | Text Validation                  |                               |
      | Record ID                        |       1                       |
      | Name                             |       Joe                     |

    # Checking for Email thrice doesn't work as expected in ATS as it might just check the first Email row for all 3 entries. 
    # But keeping it for manual testing. Same with Identifier field.
    # Not verifying Name fields in Text Validation and Data Types in Record ID 1 (Event 1) as ATS will fail. Name is present with values of Joe and John in PDF
    And I should NOT see the following values in the downloaded PDF
      | Email                            | 
      | Email                            |
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
      | Email                            |

    #VERIFY_LOG
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action                        | List of Data Changes OR Fields Exported          |
      | mm/dd/yyyy hh:mm | test_user1 | PDF Export with data Record 1 | Download all data entry forms as PDF (with data) |