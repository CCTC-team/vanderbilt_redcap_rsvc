Feature: D.106.100 - The system shall allow Data Resolution Workflow privileges to be (No Access, View only, Open queries only, Respond only to opened queries, Open and respond to queries; Open, close, and respond to queries).

  As a REDCap end user
  I want to see that Data Resolution Workflow privileges work as expected

  Scenario: D.106.100 - Data Resolution Workflow privileges
    Given I login to REDCap with the user "Test_Admin" 
    And I create a new project named "D.106.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

    #ACTION: Enable the Data Resolution Workflow
    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Additional customizations"
    And I select "Data Resolution Workflow" on the dropdown field labeled "Enable:"
    Then I click on the button labeled "Save"
    Then I should see "The Data Resolution Workflow has now been enabled!"
    And I click on the button labeled "Close" in the dialog box

    #VERIFY_LOG
    Given I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
          | Date / Time      | Username   | Action        | List of Data Changes OR Fields Exported |
          | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Make project customizations             |

    #ACTION: Add users 
    Given I click on the link labeled "User Rights"
    And I click on the button labeled "Upload or download users, roles, and assignments"
    And I click on the link labeled "Upload users (CSV)"
    And I upload a "csv" format file located at "import_files/redcap_val/D.106.100_Users.csv", by clicking the button near "Select your CSV file" to browse for the file, and clicking the button labeled "Upload" to upload the file
    And I should see "Upload users (CSV) - Confirm"
    And I click on the button labeled "Upload" in the dialog box
    And I should see "5 users were added or updated"
    And I click on the button labeled "Close" in the dialog box

    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I enter "Test" into the input field labeled "Text2"
    Then I select the submit option labeled "Save & Stay" on the Data Collection Instrument

    #ACTION: Open a query and verify data
    When I click on the Comment icon for the field labeled "Text Box"
    Then  I should see "Data Resolution Workflow" in the dialog box
    And I select the radio option Open query in Data Resolution Workflow
    And I enter "Query 1" in the comment box in Data Resolution Workflow
    And I click on the button labeled "Open query" in the dialog box
    Then I should see a Small Exclamation icon for the field labeled "Text Box"
    When I click on the Comment icon for the field labeled "Notes Box"
    And I select the radio option Verified data value in Data Resolution Workflow
    And I click on the button labeled "Verified data value" in the dialog box
    Then I should see a Tick icon for the field labeled "Notes Box"
    And I logout

    #ACTION: Verify access right - 'Open close and respond to queries', 'verify/de-verify'
    Given I login to REDCap with the user "Test_User1" 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.106.100"
    And I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I click on the Small Exclamation icon for the field labeled "Text Box"
    Then I should see a table header and row containing the following values in a table:
      | Date / Time      | User       | Comments and Details                  | 
      | mm/dd/yyyy hh:mm | Test_Admin | Action:Opened query Comment:“Query 1” |

    Then I should see "Reply with response"
    Then I should see "Close the query"
    And I should NOT see "Verified data value"
    And I click on the button labeled "Cancel" in the dialog box
    And I click on the Comment icon for the field labeled "Text2"
    Then I should see "Verified data value"
    And I should see "Open query"
    And I click on the button labeled "Cancel" in the dialog box
    And I click on the Tick icon for the field labeled "Notes Box"
    Then I should see a table header and row containing the following values in a table:
      | Date / Time      | User       | Comments and Details       | 
      | mm/dd/yyyy hh:mm | Test_Admin | Action:Verified data value |

    Then I should see "De-verify data value"
    And I click on the button labeled "Cancel" in the dialog box
    And I logout

    #ACTION: Verify access right - 'Respond only to open queries', No access to 'verify/de-verify'
    Given I login to REDCap with the user "Test_User2" 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.106.100"
    And I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I click on the Small Exclamation icon for the field labeled "Text Box"
    Then I should see a table header and row containing the following values in a table:
      | Date / Time      | User       | Comments and Details                  | 
      | mm/dd/yyyy hh:mm | Test_Admin | Action:Opened query Comment:“Query 1” |

    Then I should see "Reply with response"
    Then I should NOT see "Close the query"
    And I click on the button labeled "Cancel" in the dialog box
    Given I click on the Comment icon for the field labeled "Name"
    Then I should NOT see "Open query"
    And I should NOT see "Verified data value"
    And I should see "Awaiting action by user with sufficient user privileges"
    #There is no 'Close' button, but an 'x' icon and its label is 'Close'. There is no other step to match
    And I click on the button labeled "Close" in the dialog box
    And I click on the Tick icon for the field labeled "Notes Box"
    Then I should see a table header and row containing the following values in a table:
      | Date / Time      | User       | Comments and Details       | 
      | mm/dd/yyyy hh:mm | Test_Admin | Action:Verified data value |

    And I should see "Awaiting action by user with sufficient user privileges"
    Then I should NOT see "De-verify data value"
    #There is no 'Close' button, but an 'x' icon and its label is 'Close'. There is no other step to match
    And I click on the button labeled "Close" in the dialog box
    And I logout

    #ACTION: Verify User right - 'Open queries only', 'verify/de-verify'
    Given I login to REDCap with the user "Test_User3" 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.106.100"
    And I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I click on the Small Exclamation icon for the field labeled "Text Box"
    Then I should see a table header and row containing the following values in a table:
      | Date / Time      | User       | Comments and Details                  | 
      | mm/dd/yyyy hh:mm | Test_Admin | Action:Opened query Comment:“Query 1” |

    Then I should NOT see "Close the query"
    And I should NOT see "Respond to query"
    And I should see "Awaiting action by user with sufficient user privileges"
    And I click on the button labeled "Close" in the dialog box
    #There is no 'Close' button, but an 'x' icon and its label is 'Close'. There is no other step to match
    And I click on the Comment icon for the field labeled "Name"
    Then I should see "Open query"
    And I should see "Verified data value"
    And I click on the button labeled "Cancel" in the dialog box
    And I click on the Tick icon for the field labeled "Notes Box"
    Then I should see a table header and row containing the following values in a table:
          | Date / Time      | User       | Comments and Details       | 
          | mm/dd/yyyy hh:mm | Test_Admin | Action:Verified data value |

    Then I should see "De-verify data value"
    And I click on the button labeled "Cancel" in the dialog box
    And I logout

    #ACTION: Verify User right - 'Open and respond to queries', 'verify/de-verify'
    Given I login to REDCap with the user "Test_User4" 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.106.100"
    And I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I click on the Small Exclamation icon for the field labeled "Text Box"
    Then I should see a table header and row containing the following values in a table:
      | Date / Time      | User       | Comments and Details                  | 
      | mm/dd/yyyy hh:mm | Test_Admin | Action:Opened query Comment:“Query 1” |

    Then I should NOT see "Close the query"
    And I should see "Reply with response:"
    And I click on the button labeled "Cancel" in the dialog box
    And I click on the Comment icon for the field labeled "Name"
    Then I should see "Open query"
    And I should see "Verified data value"
    And I click on the button labeled "Cancel" in the dialog box
    And I click on the Tick icon for the field labeled "Notes Box"
    Then I should see a table header and row containing the following values in a table:
      | Date / Time      | User       | Comments and Details       | 
      | mm/dd/yyyy hh:mm | Test_Admin | Action:Verified data value |

    Then I should see "De-verify data value"
    And I click on the button labeled "Cancel" in the dialog box
    And I logout

    #ACTION: Assign user rights
    Given I login to REDCap with the user "Test_Admin" 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.106.100"
    When I click on the link labeled "User Rights"
    And I click on the link labeled "test_user3"
    And I click on the button labeled "Edit user privileges"
    And I select the User Right named Data Resolution Workflow and choose No Access
    And I click on the button labeled "Save Changes"
    Then I should see 'User "test_user3" was successfully edited'
    And I click on the link labeled "test_user4"
    And I click on the button labeled "Edit user privileges"
    And I select the User Right named Data Resolution Workflow and choose View only
    And I click on the button labeled "Save Changes"
    Then I should see 'User "test_user4" was successfully edited'
    And I logout

    #ACTION: Verify access right - 'No Access', No access to 'verify/de-verify'
    Given I login to REDCap with the user "Test_User3" 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.106.100"
    And I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should NOT see a Small Exclamation icon for the field labeled "Text Box"
    And I should NOT see a Comment icon for the field labeled "Name" 
    And I should NOT see a Tick icon for the field labeled "Notes Box" 
    And I logout

    #ACTION: Verify access right - 'View only', No access to 'verify/de-verify'
    Given I login to REDCap with the user "Test_User4" 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.106.100"
    And I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    #The below step shows a new query cannot be opened and cannot verify data value
    Then I should NOT see a Comment icon for the field labeled "Name"
    Given I click on the Small Exclamation icon for the field labeled "Text Box"
    Then I should see a table header and row containing the following values in a table:
      | Date / Time      | User       | Comments and Details                  | 
      | mm/dd/yyyy hh:mm | Test_Admin | Action:Opened query Comment:“Query 1” |

    Then I should NOT see "Close the query"
    Then I should NOT see "Respond to query"
    And I should see "Awaiting action by user with sufficient user privileges"
    #There is no 'Close' button, but an 'x' icon and its label is 'Close'. There is no other step to match
    And I click on the button labeled "Close" in the dialog box
    Given I click on the Tick icon for the field labeled "Notes Box"
    Then I should see a table header and row containing the following values in a table:
      | Date / Time      | User       | Comments and Details       | 
      | mm/dd/yyyy hh:mm | Test_Admin | Action:Verified data value |

    And I should see "Awaiting action by user with sufficient user privileges"
    Then I should NOT see "De-verify data value"
    #There is no 'Close' button, but an 'x' icon and its label is 'Close'. There is no other step to match
    And I click on the button labeled "Close" in the dialog box
    And I logout