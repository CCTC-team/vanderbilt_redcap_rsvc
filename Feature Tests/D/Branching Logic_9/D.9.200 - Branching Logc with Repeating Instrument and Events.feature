Feature: D.9.200 - The system shall support branching logic from data entry forms of repeating events/instruments.

    As a REDCap end user
    I want to see that branching logic from data entry forms of repeating events/instruments is functioning as expected

  Scenario: D.27.800

    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "D.27.800" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/D27800.xml", and clicking the "Create Project" button

    ##VERIFY: Branching logic
    When I click on the link labeled "Designer"
    And I click on the instrument labeled "Data Types"
    #Branching Logic with repeating events
    And I click on the Branching Logic icon for the variable "textbox"
    And I click on "'" in the textarea field labeled "Advanced Branching Logic Syntax" in the dialog box
    And I clear field and enter '[event_2_arm_1][name][2] != ""' in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I click on the button labeled "Save" in the dialog box
    Then I should see 'Branching logic: [event_2_arm_1][name][2] != ""' within the field with variable name "textbox"
    
    #Branching Logic with repeating instrument
    And I click on the Branching Logic icon for the variable "text2"
    And I click on "'" in the textarea field labeled "Advanced Branching Logic Syntax" in the dialog box
    And I clear field and enter '[event_three_arm_1][name][3] != ""' in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I click on the button labeled "Save" in the dialog box
    Then I should see 'Branching logic: [event_three_arm_1][name][3] != ""' within the field with variable name "text2"
    
    #VERIFY - Branching Logic
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should see "text box" in the data entry form field "Text box"
    And I should NOT see "Text2"

    #VERIFY - Branching Logic
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "2" and click on the bubble
    Then I should NOT see "Text box"
    And I should see "text2" in the data entry form field "Text2"
    And I logout