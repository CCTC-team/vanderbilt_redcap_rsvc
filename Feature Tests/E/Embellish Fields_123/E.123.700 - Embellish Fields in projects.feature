Feature: E.123.700 - The system shall support the ability to view field variable name, element type, validation type and action tags in instruments when the corresponding options are enabled in Embellish Fields external module.

  As a REDCap end user
  I want to see that Embellish Fields is functioning as expected

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
    And I should NOT see "Embellish fields - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Embellish fields"
    And I click on the button labeled "Enable" in the dialog box
    Then I should see "Embellish fields - v0.0.0"
 
  Scenario: Enable external module in project
    Given I create a new project named "E.123.700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_nodata.xml", and clicking the "Create Project" button
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Embellish fields - v0.0.0"
    Then I should see "Embellish fields - v0.0.0"

    #VERIFY - E.123.700
    And I click on the button labeled "Configure"
    When I check the checkbox labeled "When checked, the field variable name will be shown"
    And I check the checkbox labeled "When checked, the field element type will be shown"
    And I check the checkbox labeled "When checked, the field validation type will be shown"
    And I check the checkbox labeled "When checked, using action tags on questions that match the regular expression"
    And I enter "@\b[A-Z]+(?:_[A-Z]+)*\b" into the textarea field labeled "A regular expression"
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Embellish fields - v0.0.0"

    # Add User Test_User1 with 'Project Setup & Design' rights
    Given I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named "Project Setup & Design"
    Then I should see a checkbox labeled "Embellish fields" that is checked
    And I click on the button labeled "Add user"
    Then I should see "successfully added"
    And I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.123.700"

    #VERIFY - E.123.800 - Only Super-users can configure external Module
    Given I click on the link labeled exactly "Manage"
    Then I should see "Embellish fields - v0.0.0"
    And I should NOT see the button labeled "Disable"
    When I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    And I should NOT see "Hide this module from non-admins in the list of enabled modules on this project" in the dialog box
    And I should NOT see "When checked, the field variable name will be shown" in the dialog box
    And I should NOT see "When checked, the field element type will be shown" in the dialog box
    And I should NOT see "When checked, the field validation type will be shown" in the dialog box
    And I should NOT see "When checked, using action tags on questions that match the regular expression" in the dialog box
    Then I click on the button labeled "Cancel" in the dialog box
    And I should see "Embellish fields - v0.0.0"
    
  Scenario: E.123.900, E.123.1000 - Embellish Fields for Repeating Instruments in Arm 1
    # Repeating Instruments - Instance 1
    Given I click on the link labeled "Add / Edit Records"
    When I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "data_types_crfver | text | int | @SETVALUE" within the data entry field labeled "CRF Versioning"
    And I should see "ptname | text | @DEFAULT" within the data entry field labeled "Name"
    And I should see "multiple_dropdown_auto | select" within the data entry field labeled "Multiple Choice Dropdown Auto"
    And I should see "checkbox | checkbox" within the data entry field labeled "Checkbox"
    When I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    # Repeating Instruments - Instance 2
    Given I click on the button labeled "Add new"
    Then I should see "Data Types"
    And I should see "(Instance #2)"
    Then I should see "data_types_crfver | text | int | @SETVALUE" within the data entry field labeled "CRF Versioning"
    And I should see "ptname | text | @DEFAULT" within the data entry field labeled "Name"
    And I should see "multiple_dropdown_auto | select" within the data entry field labeled "Multiple Choice Dropdown Auto"
    And I should see "checkbox | checkbox" within the data entry field labeled "Checkbox"
    When I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

  Scenario: E.123.900, E.123.1000 - Embellish Fields for Repeating Events in Arm 2
    # Repeating Events - Instance 1
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the tab labeled "Arm 2"
    And I click on the button labeled "Add new record for this arm"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 2"
    And I should see "Data Types"
    Then I should see "data_types_crfver | text | int | @SETVALUE" within the data entry field labeled "CRF Versioning"
    And I should see "ptname | text | @DEFAULT" within the data entry field labeled "Name"
    And I should see "multiple_dropdown_auto | select" within the data entry field labeled "Multiple Choice Dropdown Auto"
    And I should see "checkbox | checkbox" within the data entry field labeled "Checkbox"
    When I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    # Repeating Events - Instance 2
    Given I click on the button labeled "Add new"
    When I click the bubble to add a record for the "Data Types" longitudinal instrument on event "(#2)"
    Then I should see "Data Types"
    And I should see "(Instance #2)"
    Then I should see "data_types_crfver | text | int | @SETVALUE" within the data entry field labeled "CRF Versioning"
    And I should see "ptname | text | @DEFAULT" within the data entry field labeled "Name"
    And I should see "multiple_dropdown_auto | select" within the data entry field labeled "Multiple Choice Dropdown Auto"
    And I should see "checkbox | checkbox" within the data entry field labeled "Checkbox"
    When I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"
    And I logout

  Scenario: Verify different configuration settings
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.123.700"
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Embellish fields - v0.0.0"
    When I click on the button labeled "Configure"
    Then I uncheck the checkbox labeled "When checked, the field validation type will be shown"
    And I uncheck the checkbox labeled "When checked, using action tags on questions that match the regular expression"
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Embellish fields - v0.0.0"

    #VERIFY
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the tab labeled "Arm 2"
    And I click on the link labeled exactly "2"
    When I click on the button labeled "Add new"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "(#3)"
    Then I should see "Data Types"
    And I should see "(Instance #3)"
    Then I should see "data_types_crfver | text" within the data entry field labeled "CRF Versioning"
    And I should NOT see "int | @SETVALUE"
    And I should see "ptname | text" within the data entry field labeled "Name"
    And I should NOT see "@DEFAULT"
    And I should see "multiple_dropdown_auto | select" within the data entry field labeled "Multiple Choice Dropdown Auto"
    And I should see "checkbox | checkbox" within the data entry field labeled "Checkbox"
    When I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Embellish fields - v0.0.0"
    When I click on the button labeled "Configure"
    Then I uncheck the checkbox labeled "When checked, the field variable name will be shown"
    And I uncheck the checkbox labeled "When checked, the field element type will be shown"
    Then I click on the button labeled "Save" in the dialog box
    And I should see "Embellish fields - v0.0.0"

    #VERIFY
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the tab labeled "Arm 2"
    And I click on the link labeled exactly "2"
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "(#3)"
    Then I should see "Data Types"
    And I should see "(Instance #3)"
    Then I should NOT see "data_types_crfver | text"
    And I should NOT see "ptname | text"
    And I should NOT see "multiple_dropdown_auto | select"
    And I should NOT see "checkbox | checkbox"
    When I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

  Scenario: E.123.100 - Disable external module
    # Disable external module in project
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Embellish fields - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Embellish fields - v0.0.0"

    Given I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
      | Time / Date      | Username   | Action                                                                         | List of Data Changes OR Fields Exported                                                                                                                             |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "embellish_fields_v0.0.0" for project                  |                                                                                                                                                                     |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "embellish_fields_v0.0.0" for project | show-field-variable-name, show-field-element-type                                                                                                                   |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "embellish_fields_v0.0.0" for project | show-field-validation-type, include-action-tags                                                                                                                     |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "embellish_fields_v0.0.0" for project | reserved-hide-from-non-admins-in-project-list, show-field-variable-name, show-field-element-type, show-field-validation-type, include-action-tags, action-tag-regex |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "embellish_fields_v0.0.0" for project                   |                                                                                                                                                                     |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Embellish fields - v0.0.0"

    # Not checking 'Delete Version' for now as this is used for deleting lower versions.
    # If the entire EM is deleted REDCap throws an error

    Given I click on the link labeled "User Activity Log"
    Then I should see a table header and row containing the following values in a table:
      | Time             | User       | Event                                                                          |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "embellish_fields_v0.0.0" for system                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "embellish_fields_v0.0.0" for project                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "embellish_fields_v0.0.0" for project |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "embellish_fields_v0.0.0" for project                   |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "embellish_fields_v0.0.0" for system                    |

    And I logout

    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - embellish_fields"