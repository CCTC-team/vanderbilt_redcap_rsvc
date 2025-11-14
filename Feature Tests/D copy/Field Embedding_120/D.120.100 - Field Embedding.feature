Feature: D.120.100 - The system shall support the ability to use Embedded Fields in data entry forms for better user-friendly form designs. 

  As a REDCap end user
  I want to see that Field Embedding is functioning as expected

  Scenario: D.120.100 Field Embedding
    #SETUP
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "D.120.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"
    And I click on the instrument labeled "Text Validation"
    Then I should see "Name"
    And I click on the Edit image for the field named "Email"
    And I enter "EmailField" into the Field Label of the open "Add New Field" dialog box
    Then I click on the button labeled "Save"
    Then I should see "EmailField"
    And I click on the first button labeled "Add Field"
    Then I select "Descriptive Text (with optional Image/Video/Audio/File Attachment)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "Mail ID:{{}email_v2{}}; Participant Info:{{}ptname_v2_v2{}}" into the Field Label of the open "Add New Field" dialog box
    And I enter "embed" into the Variable Name of the open "Add New Field" dialog box
    When I click on the button labeled "Save"
    Then I should see "Field is embedded elsewhere on page" within the field with variable name "ptname_v2_v2"
    And I should see "Field is embedded elsewhere on page" within the field with variable name "email_v2"
    And I should see "Contains embedded fields" within the field with variable name "embed"

    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Then I should see 'Record "2" is a new Record ID'
    
    When I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "; Participant Info:"
    And I enter "User1@example.com" into the input field labeled "Mail ID"
    And I should NOT see "Name"
    And I should NOT see "EmailField"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"

    #VERIFY_DE
    When I click on the link labeled "Logging"
    Then I should see table header and rows containing the following values in the logging table:
        | Username   | Action                                   | List of Data Changes OR Fields Exported                       |
        | test_user1 | Create record 2 (Event 1 (Arm 1: Arm 1)) | email_v2 = 'User1@example.com', text_validation_complete = '0' |
    
    And I logout