Feature: E.122.700 - The system shall support the ability to setup CRF versioning in projects through Versioning external module.

  As a REDCap end user
  I want to see that Versioning External Module work as expected

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
    And I should NOT see "Versioning - v0.0.0"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Versioning"
    And I click on the button labeled "Enable" in the dialog box
    Then I should see "Versioning - v0.0.0"
 
  Scenario: Enable external module in project
    Given I create a new project named "E.122.700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/E122700.xml", and clicking the "Create Project" button
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Versioning - v0.0.0"
    Then I should see "Versioning - v0.0.0"

    # E.122.700, E.122.900 - Only Super-admins can configure external Module
    Given I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    When I enter "crfver" into the input field labeled "Provide the suffix"
    And I enter "0" into the input field labeled "The current crf version"
    Then I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"
    When I click on the link labeled "Versioning"
    Then I should see "The current version is 0"

    # Super-Admins can down-version
    Given I click on the link labeled exactly "Manage"
    When I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    # negative values can be entered
    And I clear field and enter "-1" into the input field labeled "The current crf version"
    Then I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"
    When I click on the link labeled "Versioning"
    Then I should see "The current version is -1"

    # Upversion from configuration settings
    Given I click on the link labeled exactly "Manage"
    When I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    And I clear field and enter "1" into the input field labeled "The current crf version"
    Then I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"
    When I click on the link labeled "Versioning"
    Then I should see "The current version is 1"

    # Add User Test_User1 with 'Project Setup & Design' rights
    Given I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named "Project Setup & Design"
    Then I should see a checkbox labeled "Versioning" that is checked
    And I click on the button labeled "Add user"
    Then I should see "successfully added"
    And I logout

    #VERIFY - Only Super-users can configure the settings
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.122.700"
    Then I should see "Project Home and Design"
    When I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    # E.122.900 - Only Super-admins can configure external Module
    And I should NOT see the button labeled "Disable"
    And I click on the button labeled "Configure"
    Then I should see "Configure Module" in the dialog box
    And I should NOT see "Hide this module from non-admins in the list of enabled modules on this project" in the dialog box
    And I should NOT see "Provide the suffix used to identify the version field on a form" in the dialog box
    And I should NOT see "The current crf version" in the dialog box
    And I should NOT see "If checked, any fields identified as versioning fields will be automatically set as readonly" in the dialog box
    Then I click on the button labeled "Cancel" in the dialog box

    #VERIFY - Versioning page
    When I click on the link labeled "Versioning"
    Then I should see "The current version is 1"
    And I should NOT see "Update the version to"

    Given I click on the link labeled "Add / Edit Records"
    When I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "1" in the data entry form field "CRF Versioning"
    # Testing versioning with branching logic
    And I should see the field labeled "Email"
    And I click on the button labeled "Save & Exit Form"

    #VERIFY - Versioning field is editable
    Given I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "1" in the data entry form field "CRF Versioning"
    # Testing versioning with branching logic
    And I should NOT see the field labeled "Text2"
    When I clear field and enter "2" into the input field labeled "CRF Versioning"
    Then I should NOT see the field labeled "Text2"
    And I click on the button labeled "Save & Exit Form"
    And I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.122.700"
    
    #E.122.800 - Configure Versioning field as readonly
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I click on the button labeled "Configure"
    And I check the checkbox labeled "If checked, any fields identified as versioning fields will be automatically set as readonly"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"

    # Version number should be an integer
    Given I click on the link labeled "Versioning"
    When I enter "2.5" into the input field labeled "Update the version to"
    And I click on the button labeled "Submit"
    Then I should see "Expecting an integer between 2 and 999 but got -> 2.5"
    
    # Updating the version from Versioning page
    When I enter "3" into the input field labeled "Update the version to"
    And I click on the button labeled "Submit"
    Then I should see "Updated version number to 3"
    And I should see "The current version is 3"

    # Cannot downgrade version from Versioning page
    When I enter "2" into the input field labeled "Update the version to"
    And I click on the button labeled "Submit"
    Then I should see "Expecting the new version [2] to be at least one greater than current version [3]"

    #VERIFY - Versioning field is readonly
    Given I click on the link labeled "Add / Edit Records"
    When I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "3" in the data entry form field "CRF Versioning"
    #VERIFY E.122.800
    And I should see the field labeled "CRF Versioning" disabled
    # Testing versioning with branching logic
    And I should see the field labeled "Text2"
    Then I click on the button labeled "Save & Exit Form"

    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "2" and click on the bubble
    Then I should see "3" in the data entry form field "CRF Versioning"
    # Testing versioning with branching logic
    And I should NOT see the field labeled "Email"
    And I click on the button labeled "Save & Exit Form"

    # VERIFY - existing Versioning field is unchanged
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should see "1" in the data entry form field "CRF Versioning"
    And I click on the button labeled "Cancel"

    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should see "2" in the data entry form field "CRF Versioning"
    And I click on the button labeled "Cancel"

    # Updating the version number in the configuration settings
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I click on the button labeled "Configure"
    Then I should see "3"
    When I clear field and enter "5" into the input field labeled "The current crf version"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"

  Scenario: E.122.1000, E.122.1100 - Versioning for Repeating Instruments in Arm 1
    # Repeating Instruments - Instance 1
    Given I click on the link labeled "Add / Edit Records"
    When I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 3"
    And I should see "Data Types"
    And I should see "(Instance #1)"
    Then I should see "5" in the data entry form field "CRF Versioning"
    And I should see the field labeled "CRF Versioning" disabled
    # Testing versioning with branching logic
    And I should see the field labeled "Text2"
    Then I click on the button labeled "Save & Exit Form"

    # Repeating Instruments - Instance 2
    Given I click on the button labeled "Add new"
    Then I should see "Editing existing Record ID 3"
    And I should see "Data Types"
    And I should see "(Instance #2)"
    Then I should see "5" in the data entry form field "CRF Versioning"
    And I should see the field labeled "CRF Versioning" disabled
    Then I click on the button labeled "Save & Exit Form"

  Scenario: E.122.1000, E.122.1100 - Versioning for Repeating Events in Arm 2
    # Repeating Events - Instance 1
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the tab labeled "Arm 2"
    And I click on the button labeled "Add new record for this arm"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 4"
    And I should see "Data Types"
    And I should see "5" in the data entry form field "CRF Versioning"
    And I should see the field labeled "CRF Versioning" disabled
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    # Repeating Events - Instance 2
    Given I click on the button labeled "Add new"
    When I click the bubble to add a record for the "Data Types" longitudinal instrument on event "(#2)"
    Then I should see "Editing existing Record ID 4"
    And I should see "Data Types"
    And I should see "(Instance #2)"
    Then I should see "5" in the data entry form field "CRF Versioning"
    And I should see the field labeled "CRF Versioning" disabled
    Then I click on the button labeled "Save & Exit Form"  

  Scenario: E.122.100 - Disable external module
    # Disable external module in project
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Versioning - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Versioning - v0.0.0"

    Given I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
      | Time / Date      | Username   | Action                                                                   | List of Data Changes OR Fields Exported                                                                                             |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "versioning_v0.0.0" for project                  |                                                                                                                                     |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "versioning_v0.0.0" for project | version-field-auto-set-as-readonly                                                                                                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "versioning_v0.0.0" for project | current-project-version                                                                                                             |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "versioning_v0.0.0" for project | reserved-hide-from-non-admins-in-project-list, versioning-field-suffix, current-project-version, version-field-auto-set-as-readonly |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "versioning_v0.0.0" for project                   |                                                                                                                                     |

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Versioning - v0.0.0"

    # Not checking 'Delete Version' for now as this is used for deleting lower versions.
    # If the entire EM is deleted REDCap throws an error

    Given I click on the link labeled "User Activity Log"
    Then I should see a table header and row containing the following values in a table:
      | Time             | User       | Event                                                                    |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "versioning_v0.0.0" for system                   |
      | mm/dd/yyyy hh:mm | test_admin | Disable external module "versioning_v0.0.0" for project                  |
      | mm/dd/yyyy hh:mm | test_admin | Modify configuration for external module "versioning_v0.0.0" for project |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "versioning_v0.0.0" for project                   |
      | mm/dd/yyyy hh:mm | test_admin | Enable external module "versioning_v0.0.0" for system                    |
    
    And I logout

    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - versioning"