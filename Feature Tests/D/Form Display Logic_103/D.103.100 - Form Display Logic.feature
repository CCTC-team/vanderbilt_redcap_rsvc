Feature: D.103.100 - The system shall support the ability to display a form/instrument when a condition is met.             

  As a REDCap end user
  I want to see that Form Display Logic is functioning as expected

  Scenario: D.103.100 Form Display Logic
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "D.103.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button
    And I click on the link labeled "Designer"
    When I click on the button labeled "Form Display Logic"
    And I click on the link labeled "Edit Form Display Logic"
    And I select "Data Types [All Events]" on the dropdown field labeled "Keep the following forms enabled..."
    Then I should see "...when the logic below is TRUE."
    And I enter "[ptname_v2_v2]!=''" into the textarea field labeled "...when the logic below is TRUE."
    And I clear field and enter "[ptname_v2_v2]!=''" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    And I click on the button labeled "Close" in the dialog box

    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    ## Form is not disabled as Name is empty
    Then I should see "Data Types"
    And I cannot click the bubble for the "Data Types" longitudinal instrument which is disabled
    When I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "" in the data entry form field "Name" 
    And I enter "User 2" into the data entry form field labeled "Name"
    And I click on the button labeled "Save & Exit Form"
    # Form is enabled
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 2 successfully edited."

    Given I click on the link labeled "Designer"
    When I click on the button labeled "Form Display Logic"
    And I click on the link labeled "Edit Form Display Logic"
    And I check the checkbox labeled "Keep forms enabled if they contain data"
    And I check the checkbox labeled "Hide forms that are disabled"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    And I click on the button labeled "Close" in the dialog box

    Given I click on the link labeled "Add / Edit Records"
    When I click on the button labeled "Add new record for the arm selected above"
    And I should see "3"  
    # Hiding Data Types as it is disabled
    Then I should NOT see "Data Types"

    Given I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I enter "user3" into the data entry form field labeled "Name"
    And I click on the button labeled "Save & Exit Form"
    # Data Types enabled
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 3 successfully edited."

    Given I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I clear field and enter "" into the data entry form field labeled "Name"
    And I click on the button labeled "Save & Exit Form"
    And I should see "Record ID 3 successfully edited."
    # Data Types remains enabled as 'Keep forms enabled if they contain data'
    When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I should see "Text2"
    Then I logout