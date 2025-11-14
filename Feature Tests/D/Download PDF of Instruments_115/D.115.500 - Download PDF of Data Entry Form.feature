Feature: D.115.500 - The system shall support the ability to download the data entry form from within an instrument (instrument contains Record ID) 

  As a REDCap end user
  I want to be able to download the data entry form from within an instrument

  Scenario: Download data entry form from within an instrument
    Given I login to REDCap with the user "Test_User1"
    Then I create a new project named "D.115.500" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button
 
    #VERIFY
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I click on the button labeled "Download PDF of instrument(s)"
    And I click on the link labeled "This data entry form (blank)"
    Then I should see a downloaded file named "DataTypes_D115500.pdf"
    And I should see the following values in the downloaded PDF
        |                                  |             D.115.500         |
        | Data Types                       |                               |
        | Record ID                        |                               |
        | Name                             |                               |
        | Text2                            |                               |
        | Text Box                         |                               |
        | Notes Box                        |                               |
        | Calculated Field                 |                               |
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
   
    #VERIFY_LOG
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Download data entry form as PDF         |