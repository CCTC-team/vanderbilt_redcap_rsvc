
Feature: D.107.100 - The system shall support the ability to use Action Tags in data entry forms. The following subset of Action Tags is selected and tested: 
            D.107.100.1 - @CALCTEXT 
            D.107.100.2 - @DEFAULT 
            D.107.100.3 - @CALCDATE 
            D.107.100.4 - @NOW and @TODAY 
            D.107.100.5 - @IF 
            D.107.100.6 - @USERNAME

  As a REDCap end user
  I want to see that Action Tags is functioning as expected

  Scenario: D.107.100.1 - @CALCTEXT
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "D.107.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_ActionTags.xml", and clicking the "Create Project" button
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Action Tags Test"
    When I click on the Edit image for the field named "Years old"
    And I enter the equation "datediff([dob], 'today', 'y')" into Calculation Equation of the open "Add New Field" dialog box
    Then I click on the button labeled "Save" in the "Add New Field" dialog box
    When I click on the Edit image for the field named "Difference"
    And I click on the textarea labeled "Action Tags / Field Annotation"
    And I clear field and enter "@CALCTEXT(if([years] >= 10, 'Greater than or equal to 10', 'Less than 10'))" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor"
    And I enter "@CALCTEXT(if([years] >= 10, 'Greater than or equal to 10', 'Less than 10'))" into the input field labeled "Field Note"
    Then I click on the button labeled "Save"
    #VERIFY
    Given I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    When I click the bubble to select a record for the "Action Tags Test" longitudinal instrument on event "Status"
    Then I should see "" in the data entry form field "DOB"
    And I should see "" in the data entry form field "Years old"
    And I should see "Less than 10" in the data entry form field "Difference"
    When I enter "19-11-1978" into the input field labeled "DOB"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see "Greater than or equal to 10" in the data entry form field "Difference" 
    When I click on the "Today" button for the field labeled "DOB"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see "0" in the data entry form field "Years old" 
    And I should see "Less than 10" in the data entry form field "Difference" 
    
  Scenario: D.107.100.2 - @DEFAULT
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Action Tags Test"
    When I click on the Edit image for the field named "Favorite Disney Character"
    And I click on the textarea labeled "Action Tags / Field Annotation"
    And I clear field and enter "@DEFAULT='5'" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor"
    And I enter "@DEFAULT='5'" into the input field labeled "Field Note"
    Then I click on the button labeled "Save"
    When I click on the Edit image for the field named "What sport do you like the most"
    And I click on the textarea labeled "Action Tags / Field Annotation"
    And I clear field and enter '@DEFAULT="Gymnastics"' in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor"
    And I enter '@DEFAULT="Gymnastics"' into the input field labeled "Field Note"
    Then I click on the button labeled "Save"
    #VERIFY
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    When I click the bubble to select a record for the "Action Tags Test" longitudinal instrument on event "Status"
    Then I should see the radio labeled "Favorite Disney Character" with option "Goofy" selected
    And I should see "Gymnastics" in the data entry form field "What sport do you like the most"
    Then I clear field and enter "Football" into the input field labeled "What sport do you like the most" 
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: D.107.100.3 - @CALCDATE
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Action Tags Test"
    When I click on the Edit image for the field named "Next Visit Due"
    And I click on the textarea labeled "Action Tags / Field Annotation"
    And I clear field and enter "@CALCDATE([visit], 7, 'd')" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor"
    And I enter "@CALCDATE([visit], 7, 'd')" into the input field labeled "Field Note"
    Then I click on the button labeled "Save"
    #VERIFY
    Given I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    When I click the bubble to select a record for the "Action Tags Test" longitudinal instrument on event "Status"
    Then I should see "" in the data entry form field "Visit Date"
    When I enter "02/09/2023" into the input field labeled "Visit Date"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see "@CALCDATE(02-09-2023, 7, 'd')"
    And I should see "09-09-2023" in the data entry form field "Next Visit Due"

  Scenario: D.107.100.4 - @NOW and @TODAY
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Action Tags Test2"
    When I click on the Edit image for the field named "Now"
    And I click on the textarea labeled "Action Tags / Field Annotation"
    And I clear field and enter "@NOW" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor"
    And I enter "@NOW" into the input field labeled "Field Note"
    Then I click on the button labeled "Save"
    When I click on the Edit image for the field named "Today's Date"
    And I click on the textarea labeled "Action Tags / Field Annotation"
    And I clear field and enter "@TODAY" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor"
    And I enter "@TODAY" into the input field labeled "Field Note"
    Then I click on the button labeled "Save"
    #VERIFY
    Given I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    When I click the bubble to select a record for the "Action Tags Test2" longitudinal instrument on event "Status"
    Then I should see the exact time in the field labeled "Now"
    And I should see today's date in the field labeled "Today" 
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: D.107.100.5 - @IF
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Action Tags Test2"
    When I click on the Edit image for the field named "What are your preferred appointment times?"
    And I click on the textarea labeled "Action Tags / Field Annotation"
    And I clear field and enter "@IF([weekend_yn] = '0', @HIDECHOICE='6', '')" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor"
    Then I click on the button labeled "Save"
    #VERIFY
    Given I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    When I click the bubble to select a record for the "Action Tags Test2" longitudinal instrument on event "Status"
    And I select the radio option "Yes" for the field labeled "Are you able to attend weekend appointments?" 
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see "Monday 8am - 9am"
    And I should see "Tuesday 10am - 11am"
    And I should see "Wednesday 12pm - 1pm"
    And I should see "Thursday 2pm - 3pm"
    And I should see "Friday 4pm - 5pm"
    And I should see "Saturday 10am - 11am"

    When I select the radio option "No" for the field labeled "Are you able to attend weekend appointments?" 
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should NOT see "Saturday 10am - 11am"
    And I should see "Monday 8am - 9am"
    And I should see "Tuesday 10am - 11am"
    And I should see "Wednesday 12pm - 1pm"
    And I should see "Thursday 2pm - 3pm"
    And I should see "Friday 4pm - 5pm"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

  Scenario: D.107.100.6 - @USERNAME
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Action Tags Test2"
    When I click on the Edit image for the field named "Username"
    And I click on the textarea labeled "Action Tags / Field Annotation"
    And I clear field and enter "@USERNAME" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor"
    And I enter "@USERNAME" into the input field labeled "Field Note"
    Then I click on the button labeled "Save"

    Given I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    When I click the bubble to select a record for the "Action Tags Test2" longitudinal instrument on event "Status"
    Then I should see "test_user1" in the data entry form field "Username"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I logout