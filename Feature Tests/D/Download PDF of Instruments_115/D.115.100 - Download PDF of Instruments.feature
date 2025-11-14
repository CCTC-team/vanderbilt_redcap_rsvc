
Feature: D.115.100 - The system shall support the ability to download the PDF of instruments 

  As a REDCap end user
  I want to be able to download a PDF of instruments

  Scenario: D.115.100 - Download PDF of Instruments
    Given I login to REDCap with the user "Test_User1"
    Then I create a new project named "D.115.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    #VERIFY
    When I click on the link labeled "Designer"
    And I click on the instrument labeled "Text Validation"
    And I click on the Edit image for the field named "Email"
    And I enter "email" into the input field labeled "Field Note"
    Then I click on the button labeled "Save"
    When I click on the link labeled "Project Setup"
    And I click on the link labeled "Download PDF of all instruments"
    Then I should see a downloaded file named "D115100.pdf"
    And I should see the following values in the downloaded PDF
      |                                  |             D.115.100         |
      | Text Validation                  |                               |
      | Record ID                        |                               |
      | Name                             |                               |
      | Email                            |                               |
      |                                  |                (email)        |
      | Data Types                       |                               |
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
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Download all data entry forms as PDF    |
      
    Given I click on the link labeled "Designer"
    When I click on the instrument labeled "Data Types"
    And I click on the button labeled "Dismiss"
    And I click on the Delete Field image for the field named "Signature"
    And I click on the button labeled "Delete" in the dialog box
    Then I should NOT see a field labeled "Signature"
    And I click on the Delete Field image for the field named "File Upload"
    And I click on the button labeled "Delete" in the dialog box
    Then I should NOT see a field labeled "File Upload"
    And I click on the Delete Field image for the field named "Required"
    And I click on the button labeled "Delete" in the dialog box
    Then I should NOT see a field labeled "Required"
    And I click on the Delete Field image for the field named "Descriptive Text with File"
    And I click on the button labeled "Delete" in the dialog box
    Then I should NOT see a field labeled "Descriptive Text with File"

    #VERIFY
    Given I click on the link labeled "Project Setup"
    When I click on the link labeled "Download PDF of all instruments"
    Then I should see a downloaded file named "D115100.pdf"
    And I should NOT see the following values in the downloaded PDF
      | Signature                        |
      | File Upload                      |
      | Required                         |
      | Descriptive Text with File       |  
      | [Attachment: "7_image_v913.jpg"] |