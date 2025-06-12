Feature: D.109.100 - The system shall support the ability to use previously collected data in a text on a data collection form or survey. 

  As a REDCap end user
  I want to see that Piping feature is functioning as expected

  Scenario: D.109.100 - Piping
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "D.109.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button
    When I click on the link labeled "Designer" 
    And I click on the instrument labeled "Data Types"
    And I click on the button labeled "Dismiss"
    When I click on the first button labeled "Add Field"
    And I select "Multiple Choice - Radio Buttons (Single Answer)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "What is your favorite ice cream?" into the Field Label of the open "Add New Field" dialog box
    And I enter "ice_cream" into the Variable Name of the open "Add New Field" dialog box
    And I enter Choices of "1, Chocolate" into the open "Add New Field" dialog box
    And I enter Choices of "2, Strawberry" into the open "Add New Field" dialog box
    And I enter Choices of "3, Vanilla" into the open "Add New Field" dialog box
    And I click on the button labeled "Save" in the "Add New Field" dialog box    
    Then I should see the radio field labeled "What is your favorite ice cream?" with the options below
      | Chocolate     |
      | Strawberry    |
      | Vanilla       |

    #ACTION: Pipe the field
    When I click on the first button labeled "Add Field"
    And I select "Slider / Visual Analog Scale" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "How much do you love [ice_cream]?" into the Field Label of the open "Add New Field" dialog box
    And I enter "love_icecream" into the Variable Name of the open "Add New Field" dialog box
    And I enter "Hate it" into the input field labeled "Left label (bottom, if vertical):" in the dialog box
    And I enter "Indifferent" into the input field labeled "Middle label:" in the dialog box
    And I enter "I love [ice_cream]" into the input field labeled "Right label (top, if vertical):" in the dialog box
    And I click on the checkbox element labeled "Display number value?" 
    And I click on the button labeled "Save" in the "Add New Field" dialog box    
    Then I should see the field labeled "How much do you love [ice_cream]?"

    #VERIFY:
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should see the field labeled "How much do you love ______"
    And I should see "I love ____"

    When I select the radio option "Chocolate" for the field labeled "What is your favorite ice cream?" 
    Then I should see a field named "How much do you love Chocolate?" 
    And I should see "I love Chocolate"

    When I select the radio option "Strawberry" for the field labeled "What is your favorite ice cream?" 
    And I should see a field named "How much do you love Strawberry?"
    And I should see "I love Strawberry"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record Home Page"
    And I logout