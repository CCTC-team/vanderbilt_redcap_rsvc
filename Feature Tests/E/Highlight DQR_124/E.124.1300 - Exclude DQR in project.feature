Feature: E.124.1300 - The system shall support the ability to view excluded data quality rules in instruments based on user roles using Highlight DQ Rules external module.

  As a REDCap end user
  I want to see that Highlight DQ Rules External Module work as expected

  Scenario: Enable external Module from Control Center
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    # EMAIL ADDRESS SET FOR REDCAP ADMIN - without it, emails are not send out from system
    When I click on the link labeled "General Configuration"
    Then I should see "General Configuration"
    When I enter "redcap@test.instance" into the input field labeled "Email Address of REDCap Administrator"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"

    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Module Manager"
    And I should NOT see "Highlight DQ Rules - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Highlight DQ Rules"
    And I click on the button labeled "Enable" in the dialog box
    Then I should see "Highlight DQ Rules - v0.0.0"
 
  Scenario: Enable external module in project
    Given I create a new project named "E.124.1200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/E1241200.xml", and clicking the "Create Project" button

    #ACTION: Enable the Data Resolution Workflow
    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Additional customizations"
    And I select "Data Resolution Workflow" on the dropdown field labeled "Enable:"
    Then I click on the button labeled "Save"
    Then I should see "The Data Resolution Workflow has now been enabled!"
    And I click on the button labeled "Close" in the dialog box

    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Highlight DQ Rules - v0.0.0"
    Then I should see "Highlight DQ Rules - v0.0.0"

    # Configure external Module
    Given I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    When I select "DataManager" on the dropdown field labeled "1. A role that can view the highlight DQ rule errors"
    And I click on the button labeled "+" in the dialog box
    When I select "Monitor" on the dropdown field labeled "2. A role that can view the highlight DQ rule errors"
    Then I click on the button labeled "Save" in the dialog box
    Then I should see "Highlight DQ Rules - v0.0.0"

    # Add User Test_User2 to DataManager user role
    Given I click on the link labeled "User Rights"
    When I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "DataManager" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User2" within the "DataManager" row of the column labeled "Username" of the User Rights table

    When I click on the link labeled "DataManager"
    Then I should see 'Editing existing user role "DataManager"'
    And I select the User Right named Data Resolution Workflow and choose Open, close, and respond to queries
    And I check the User Right named "Data Quality - Execute rules"
    And I click on the button labeled "Save Changes"
    And I logout

  Scenario: Exclude DQR referencing fields from two CRFs
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.1200"
    Given I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I locate the bubble for the "Data Types" instrument on event "Event 2" for record ID "1" and click on the bubble
    Then I should see "Data Types"
    And I should see "Data quality errors for current form"
    And I should see "Name not Name1" in the Data quality error table
    And I should see "[ptname] != 'Name1'" in the Data quality error table
    And I should see "Names are different" in the Data quality error table
    And I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]" in the Data quality error table

    When I click on the link labeled "Text Validation"
    Then I should see "Text Validation"
    And I should see "Data quality errors for current form"
    And I should see "Names are different" in the Data quality error table
    And I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]" in the Data quality error table

    # Verify DQR
    Given I click on the link labeled "Data Quality"
    And I click on the button labeled exactly "All"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name              | Rule Logic (Show discrepancy only if...)                    | Total Discrepancies |
      | 1      | Identifier more than 8 | [identifier] > 8                                            | 5                   |
      | 2      | Name not Name1         | [ptname] != 'Name1'                                         | 8                   |
      | 3      | Names are different    | [event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]    | 1                   |

    When I click on the "view" link for Data Quality Rule # "3"
    Then I should see "Rule #3: Names are different" in the dialog box
    And I should see "Discrepancies found: 1" in the dialog box
    And I click on the button labeled "comments" in the dialog box
    When I select the radio option Verified data value in Data Resolution Workflow
    And I enter "Verify DQR" in the comment box in Data Resolution Workflow
    And I click on the button labeled "Verified data value" in the dialog box
    And I wait for 1 second
    Then I should NOT see "Data Resolution Workflow"
    And I click on the button labeled "Close"
    Then I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]"
    When I click on the button labeled "Clear"
    And I click on the button labeled exactly "All"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name              | Rule Logic (Show discrepancy only if...)                    | Total Discrepancies |
      | 1      | Identifier more than 8 | [identifier] > 8                                            | 5                   |
      | 2      | Name not Name1         | [ptname] != 'Name1'                                         | 8                   |
      | 3      | Names are different    | [event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]    | 1                   |

    When I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I locate the bubble for the "Data Types" instrument on event "Event 2" for record ID "1" and click on the bubble
    Then I should see "Data Types"
    And I should see "Data quality errors for current form"
    And I should see "Name not Name1" in the Data quality error table
    And I should see "[ptname] != 'Name1'" in the Data quality error table
    And I should see "Data quality errors that have been excluded for the current form"
    And I should see "Names are different" in the Data quality exclusion table
    And I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]" in the Data quality exclusion table

    When I click on the link labeled "Text Validation"
    Then I should see "Text Validation"
    And I should see "Data quality errors that have been excluded for the current form"
    And I should see "Names are different" in the Data quality exclusion table
    And I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]" in the Data quality exclusion table
    And I logout

    # Verify setting Excluded rules are not shown in a table
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.1200"
    Then I should see "Project Home and Design"
    When I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I click on the button labeled "Configure"
    Then I should see "Configure Module"
    And I check the checkbox labeled "When checked, the excluded rules are not shown in a table below the errored rules" in the dialog box
    When I click on the button labeled "Save" in the dialog box
    Then I should see "Highlight DQ Rules - v0.0.0"
    And I logout

    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.1200"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I locate the bubble for the "Data Types" instrument on event "Event 2" for record ID "1" and click on the bubble
    And I should NOT see "Data quality errors that have been excluded for the current form"
    And I should NOT see "Names are different"
    And I should NOT see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]"
    And I should see "Data quality errors for current form"
    And I should see "Name not Name1" in the Data quality error table
    And I should see "[ptname] != 'Name1'" in the Data quality error table

    When I click on the link labeled "Text Validation"
    Then I should see "Text Validation"
    And I should NOT see "Data quality errors that have been excluded for the current form"
    And I should NOT see "Names are different"
    And I should NOT see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]"
    And I logout

    # Excluded rules are shown in a table
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.1200"
    Then I should see "Project Home and Design"
    When I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I click on the button labeled "Configure"
    Then I should see "Configure Module"
    And I uncheck the checkbox labeled "When checked, the excluded rules are not shown in a table below the errored rules" in the dialog box
    When I click on the button labeled "Save" in the dialog box
    Then I should see "Highlight DQ Rules - v0.0.0"
    And I logout

    # De-verify DQR
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.1200"
    Given I click on the link labeled "Data Quality"
    And I click on the button labeled exactly "All"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name              | Rule Logic (Show discrepancy only if...)                    | Total Discrepancies |
      | 1      | Identifier more than 8 | [identifier] > 8                                            | 5                   |
      | 2      | Name not Name1         | [ptname] != 'Name1'                                         | 8                   |
      | 3      | Names are different    | [event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]    | 1                   |

    When I click on the "view" link for Data Quality Rule # "3"
    Then I should see "Rule #3: Names are different" in the dialog box
    And I should see "Discrepancies found: 1" in the dialog box
    And I click on the button labeled "comment" in the dialog box
    When I select the radio option De-verify data value in Data Resolution Workflow
    And I enter "De-verify DQR" in the comment box in Data Resolution Workflow
    And I click on the button labeled "De-verify data value" in the dialog box
    And I wait for 1 second
    Then I should NOT see "Data Resolution Workflow"
    And I click on the button labeled "Close"
    Then I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]"
    When I click on the button labeled "Clear"
    And I click on the button labeled exactly "All"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name              | Rule Logic (Show discrepancy only if...)                    | Total Discrepancies |
      | 1      | Identifier more than 8 | [identifier] > 8                                            | 5                   |
      | 2      | Name not Name1         | [ptname] != 'Name1'                                         | 8                   |
      | 3      | Names are different    | [event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]    | 1                   |

    When I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I locate the bubble for the "Data Types" instrument on event "Event 2" for record ID "1" and click on the bubble
    Then I should see "Data Types"
    And I should see "Data quality errors for current form"
    And I should see "Name not Name1" in the Data quality error table
    And I should see "[ptname] != 'Name1'" in the Data quality error table
    And I should see "Names are different" in the Data quality error table
    And I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]" in the Data quality error table

    When I click on the link labeled "Text Validation"
    Then I should see "Text Validation"
    And I should see "Data quality errors for current form"
    And I should see "Names are different" in the Data quality error table
    And I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]" in the Data quality error table

   # Re-verify DQR
    Given I click on the link labeled "Data Quality"
    And I click on the button labeled exactly "All"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name              | Rule Logic (Show discrepancy only if...)                    | Total Discrepancies |
      | 1      | Identifier more than 8 | [identifier] > 8                                            | 5                   |
      | 2      | Name not Name1         | [ptname] != 'Name1'                                         | 8                   |
      | 3      | Names are different    | [event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]    | 1                   |

    When I click on the "view" link for Data Quality Rule # "3"
    Then I should see "Rule #3: Names are different" in the dialog box
    And I should see "Discrepancies found: 1" in the dialog box
    And I click on the button labeled "comments" in the dialog box
    When I select the radio option Verified data value in Data Resolution Workflow
    And I enter "Re-verify DQR" in the comment box in Data Resolution Workflow
    And I click on the button labeled "Verified data value" in the dialog box
    And I wait for 1 second
    Then I should NOT see "Data Resolution Workflow"
    And I click on the button labeled "Close"
    Then I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]"
    When I click on the button labeled "Clear"
    And I click on the button labeled exactly "All"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name              | Rule Logic (Show discrepancy only if...)                    | Total Discrepancies |
      | 1      | Identifier more than 8 | [identifier] > 8                                            | 5                   |
      | 2      | Name not Name1         | [ptname] != 'Name1'                                         | 8                   |
      | 3      | Names are different    | [event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]    | 1                   |

    When I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    And I locate the bubble for the "Data Types" instrument on event "Event 2" for record ID "1" and click on the bubble
    Then I should see "Data Types"
    And I should see "Data quality errors for current form"
    And I should see "Name not Name1" in the Data quality error table
    And I should see "[ptname] != 'Name1'" in the Data quality error table
    And I should see "Data quality errors that have been excluded for the current form"
    And I should see "Names are different" in the Data quality exclusion table
    And I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]" in the Data quality exclusion table

    When I click on the link labeled "Text Validation"
    Then I should see "Text Validation"
    And I should see "Data quality errors that have been excluded for the current form"
    And I should see "Names are different" in the Data quality exclusion table
    And I should see "[event_2_arm_1][ptname_v2_v2] != [event_2_arm_1][ptname]" in the Data quality exclusion table
    And I logout

  Scenario: E.124.100 - Disable external module
    # Disable external module in project
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.124.1200"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Highlight DQ Rules - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Highlight DQ Rules - v0.0.0"

    Given I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
      | Time / Date      | Username   | Action                                                                           | List of Data Changes OR Fields Exported                                                                                                       |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "highlight_dq_rules_v0.0.0" for project                  |                                                                                                                                               |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "highlight_dq_rules_v0.0.0" for project | dont-show-excluded-table                                                                                                                      |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "highlight_dq_rules_v0.0.0" for project | reserved-hide-from-non-admins-in-project-list, user-roles-can-view, highlight-dq-inline, dont-show-excluded-table, dont-reset-field-data-icon |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "highlight_dq_rules_v0.0.0" for project                   |                                                                                                                                               |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Highlight DQ Rules - v0.0.0"

    # Not checking 'Delete Version' for now as this is used for deleting lower versions.
    # If the entire EM is deleted REDCap throws an error

    Given I click on the link labeled "User Activity Log"
    Then I should see a table header and row containing the following values in a table:
      | Time             | User       | Event                                                                            |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "highlight_dq_rules_v0.0.0" for system                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "highlight_dq_rules_v0.0.0" for project                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "highlight_dq_rules_v0.0.0" for project |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "highlight_dq_rules_v0.0.0" for project                   |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "highlight_dq_rules_v0.0.0" for system                    |

    And I logout

    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - highlight_dq_rules"