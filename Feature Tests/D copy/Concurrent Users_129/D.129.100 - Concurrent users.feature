Feature: D.129.100 - The system shall prevent multiple users from concurrently editing the same instrument within a project.

    As a REDCap end user
    I want to see that users cannot access the same instrument at the same time

  Scenario: D.129.100
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "D.129.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    When I click on the link labeled "User Rights"
    And I enter "Test_User2" into the field with the placeholder text of "Add new user"
    And I click on the button labeled "Add with custom rights"
    And I click on the button labeled "Add user"
    Then I should see "Test User2"

    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should see "6" in the data entry form field "Calculated Field"

    Given I login to REDCap with the user "Test_User2"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.129.100"
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should see "Simultaneous users - Data editing capabilities are disabled (read-only mode)"

  Scenario: D.129.200
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should NOT see "Simultaneous users - Data editing capabilities are disabled (read-only mode)"
    And I clear field and enter "Name1" into the data entry form field labeled "Name"