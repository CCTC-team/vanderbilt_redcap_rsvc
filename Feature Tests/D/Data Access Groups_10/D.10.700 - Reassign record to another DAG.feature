Feature: D.10.700 - The system shall provide the ability to reassign a record from one DAG to another for users with appropriate user rights

  As a REDCap end user
  I want to see that reassign a record from one DAG to another works as expected.

  Scenario: D.10.700 - Reassign a record from one DAG to another
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "D.10.700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/D10700.xml", and clicking the "Create Project" button
   
    #ACTION: Add Test_User1 with Custom rights
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see a dialog containing the following text: "Adding new user"
    And I save changes within the context of User Rights

    #ACTION: Add Test_User2 with Custom rights
    And I enter "Test_User2" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see a dialog containing the following text: "Adding new user"
    And I save changes within the context of User Rights

    #ACTION: Assign Test User1 to TestGroup1
    Given I click on the link labeled "DAGs"
    When I select "test_user1 (Test User1)" on the dropdown field labeled "Assign user"
    When I select "TestGroup1" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"

    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups | Users in group |
      | TestGroup1         | test_user1     |
      | TestGroup2         |                |

    #ACTION: Assign Test User2 to TestGroup2
    When I select "test_user2 (Test User2)" on the dropdown field labeled "Assign user"
    When I select "TestGroup2" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"

    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups | Users in group |
      | TestGroup1         | test_user1     |
      | TestGroup2         | test_user2     |

    ##FUNCTIONAL REQUIREMENT - Reassign record to another DAG
    Given I click on the link labeled "Record Status Dashboard" 
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1-1       |
      | 1-2       |
      | 2-1       |
      | 2-2       |    
      
    When I select "TestGroup2" on the dropdown field labeled "Displaying Data Access Group"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 2-1       |
      | 2-2       |

    When I select "TestGroup1" on the dropdown field labeled "Displaying Data Access Group"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1-1       |
      | 1-2       |

    And I click on the link labeled "1-2"
    Then I should see "Record Home Page"
    And I click on the span element labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group (or unassign/reassign)"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"

    When I select "TestGroup2" on the dropdown field labeled "Assign record" on the dialog box
    And I click on the button labeled "Assign to Data Access Group" in the dialog box
    Then I should see "Record ID 1-2 was successfully assigned to a Data Access Group"
    And I logout

    #VERIFY
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "D.10.700"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID       |
      | 1-2  TestGroup2 |
      | 2-1  TestGroup2 |
      | 2-2  TestGroup2 |

    When I click on the link labeled "1-2"
    Then I should see "Record Home Page"
    And I click on the span element labeled "Choose action for record"
    Then I should NOT see "Assign to Data Access Group (or unassign/reassign)"
    And I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "D.10.700"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID       |
      | 1-1  TestGroup1 |
    
    And I should NOT see a link labeled "1-2"
    When I click on the link labeled "1-1"
    Then I should see "Record Home Page"
    And I click on the span element labeled "Choose action for record"
    Then I should NOT see "Assign to Data Access Group (or unassign/reassign)"
    And I logout