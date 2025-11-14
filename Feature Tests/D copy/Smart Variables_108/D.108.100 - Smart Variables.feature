Feature: D.108.100 - The system shall support the ability to use Smart Variables in data entry forms. The following subset of Smart Variables is selected and tested: 
    D.108.100.1 - [event-label]  
    D.108.100.2 - [record-dag-id]  
    D.108.100.3 - [user-role-label] 
    D.108.100.4 - [instrument-name] 
    D.108.100.5 - [user-fullname]   

  As a REDCap end user
  I want to see that smart variables feature is functioning as expected
 
  Scenario: Project setup
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "D.108.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button   
    
    # Add Test_User1
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see a dialog containing the following text: "Adding new user"
    And I save changes within the context of User Rights

    # Add Test_User1 to TestRole
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    Then I select "TestRole" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "TestRole" row of the column labeled "Username" of the User Rights table

    # Add Test_User1 to DAG1
    When I click on the link labeled "DAGs"
    When I select "test_user1 (Test User1)" on the dropdown field labeled "Assign user"
    And I select "DAG1" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"

    # Test_User1 is assigned to DAG1 (Group ID number 1)
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups | Users in group         | Group ID number |
      | DAG1               |test_user1 (Test User1) | 1               |         

    And I logout

  Scenario: D.108.100.1 - [event-label]
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"  
    And I click on the link labeled "D.108.100" 
    Then I click on the link labeled "Designer"
    And I should see "Text Validation"
    When I click on the instrument labeled "Text Validation"
    And I click on the first button labeled "Add Field"
    And I select "Descriptive Text (with optional Image/Video/Audio/File Attachment)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "Event Label: [event-label]" into the Field Label of the open "Add New Field" dialog box
    And I enter "event_label" into the Variable Name of the open "Add New Field" dialog box
    Then I click on the button labeled "Save" in the "Add New Field" dialog box    

    #VERIFY: [event-label] shows correctly in instrument
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Then I should see "Record Home Page"
    And I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see a field named "Event Label: Event 1"
    And I click on the button labeled "Save & Exit Form"
    When I should see "Record Home Page"
    # Add instrument in another event and check

  Scenario: D.108.100.2 - [record-dag-id] 
    When I click on the link labeled "Designer"
    And I click on the instrument labeled "Text Validation"
    And I click on the first button labeled "Add Field"
    And I select "Descriptive Text (with optional Image/Video/Audio/File Attachment)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "Group ID Assigned: [record-dag-id]" into the Field Label of the open "Add New Field" dialog box
    And I enter "dag_id" into the Variable Name of the open "Add New Field" dialog box
    Then I click on the button labeled "Save" in the "Add New Field" dialog box 
    
    #VERIFY: [record-dag-id] shows correctly in instrument
    When I click on the link labeled "Add / Edit Records"
    And I select record ID "1-1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    Then I should see "Record Home Page"
    And I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see a field named "Group ID Assigned: 1"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"
    
  Scenario: D.108.100.3 - [user-role-label]
    Given I click on the link labeled "Designer"
    And I should see "Text Validation"
    When I click on the instrument labeled "Text Validation"
    And I click on the first button labeled "Add Field"
    And I select "Descriptive Text (with optional Image/Video/Audio/File Attachment)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "User role: [user-role-label]" into the Field Label of the open "Add New Field" dialog box
    And I enter "user_role" into the Variable Name of the open "Add New Field" dialog box
    Then I click on the button labeled "Save" in the "Add New Field" dialog box 

    #VERIFY: [user-role-label] shows correctly in instrument
    When I click on the link labeled "Add / Edit Records"
    And I select record ID "1-1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    Then I should see "Record Home Page"
    And I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see a field named "User role: TestRole"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record Home Page"

  Scenario: D.108.100.4 - [instrument-name]
    When I click on the link labeled "Designer"
    And I click on the instrument labeled "Text Validation"
    And I click on the first button labeled "Add Field"
    And I select "Descriptive Text (with optional Image/Video/Audio/File Attachment)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "Instrument Name: [instrument-name]" into the Field Label of the open "Add New Field" dialog box
    And I enter "instrument_name" into the Variable Name of the open "Add New Field" dialog box
    Then I click on the button labeled "Save"

    #VERIFY: [instrument-name] shows correctly in instrument
    When I click on the link labeled "Add / Edit Records"
    And I select record ID "1-1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    Then I should see "Record Home Page" 
    And I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see a field named "Instrument Name: text_validation"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record Home Page"

  Scenario: D.108.100.5 [user-fullname]
    When I click on the link labeled "Designer"
    And I click on the instrument labeled "Text Validation"
    And I click on the first button labeled "Add Field"
    And I select "Descriptive Text (with optional Image/Video/Audio/File Attachment)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "User Fullname: [user-fullname]" into the Field Label of the open "Add New Field" dialog box
    And I enter "user_fullname" into the Variable Name of the open "Add New Field" dialog box
    Then I click on the button labeled "Save"

    #VERIFY: [user-fullname] shows correctly in instrument
    When I click on the link labeled "Add / Edit Records"
    And I select record ID "1-1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    Then I should see "Record Home Page"
    And I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see a field named "User Fullname: Test User1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record Home Page"
    And I logout