Feature: E.122.100 - The system shall support the ability to enable/disable Versioning external module.

  As a REDCap end user
  I want to see that Versioning External Module work as expected

  Scenario: E.122.100 - Enable external Module - Default settings
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
    And I logout
    
    Given I login to REDCap with the user "Test_User1"
    When I create a new project named "E.122.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_nodata.xml", and clicking the "Create Project" button
    And I should NOT see a link labeled "Versioning"
    And I should NOT see a link labeled exactly "Manage"
    And I logout

  Scenario: E.122.200 - Enable module on all projects by default
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Module Manager"
    And I should see "Versioning - v0.0.0"
    And I should NOT see "Enabled for All Projects"
    When I click on the button labeled exactly "Configure"
    Then I should see "Configure Module" in the dialog box
    And I check the checkbox labeled "Enable module on all projects by default"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"
    And I should see "Enabled for All Projects"
    And I logout
    
    Given I login to REDCap with the user "Test_User1"
    When I create a new project named "E.122.100.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_nodata.xml", and clicking the "Create Project" button
    And I should see a link labeled "Versioning"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Versioning - v0.0.0"
    And I should see "Enabled for All Projects"
    And I logout

  Scenario: E.122.300 - Make module discoverable by users
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"   
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Module Manager"
    And I should see "Versioning - v0.0.0"
    And I should see "Enabled for All Projects"
    And I should NOT see "Discoverable"
    When I click on the button labeled exactly "Configure"
    And I uncheck the checkbox labeled "Enable module on all projects by default"
    And I check the checkbox labeled "Make module discoverable by users"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"
    And I should NOT see "Enabled for All Projects"
    And I should see "Discoverable"
    And I logout
    
    Given I login to REDCap with the user "Test_User1"
    When I create a new project named "E.122.100.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_nodata.xml", and clicking the "Create Project" button
    And I should NOT see a link labeled "Versioning"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see "Versioning - v0.0.0"

    When I click on the button labeled "View available modules"
    Then I should see "Versioning - v0.0.0"
    And I should see "Discoverable"
    And I should NOT see "Activation request is pending"
    When I click on the button labeled Request Activation for the external module named "Versioning"
    Then I should see "Your external module activation request has been sent to a REDCap administrator for review." in the dialog box
    And I click on the button labeled "Close" in the dialog box
    And I should NOT see "Versioning - v0.0.0"

    When I click on the button labeled "View available modules"
    Then I should see "Versioning - v0.0.0"
    And I should see "Discoverable"
    And I should see "Activation request is pending"
    And I logout

    ## Commenting this as HTML is not loading into iframe
    ## Hence this is done manually
    # Given I login to REDCap with the user "Test_Admin"
    # When I click on the link labeled "Control Center"
    # Then I should see a link labeled "To-Do List"

    # Given I click on the link labeled "To-Do List"
    # Then I should see "Pending Requests"
    # And I should see the "Activate external module" request created for the project named "E.122.100.300" within the Pending Requests table
    # When I click on the process request icon for the "Activate external module" request created for the project named "E.122.100.300" within the Pending Requests table
    # # HTML is not loading into iFrame
    # Then I should see "Enable module 'Versioning - '?" in the dialog box in the iframe
    # And I click on the button labeled "Enable" in the dialog box in the iframe
    # And I close the iframe window
    # Then I should see the "Activate external module" request created for the project named "E.122.100.300" within the Completed & Archived Requests table
    # And I logout

    # Given I login to REDCap with the user "Test_User1"
    # When I click on the link labeled "My Projects"
    # And I click on the link labeled "E.122.100.300"
    # And I should see a link labeled "Versioning"
    # And I click on the link labeled exactly "Manage"
    # Then I should see "External Modules - Project Module Manager"
    # And I should see "Versioning - v0.0.0"
    # And I should see "Discoverable"
    # And I logout

  Scenario: E.122.400 - Allow non-admins to enable this module on projects
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"   
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Module Manager"
    And I should see "Versioning - v0.0.0"
    And I should see "Discoverable"
    When I click on the button labeled exactly "Configure"
    And I check the checkbox labeled "Allow non-admins to enable this module on projects"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"
    And I should see "Discoverable"
    And I logout
    
    Given I login to REDCap with the user "Test_User1"
    When I create a new project named "E.122.100.400" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_nodata.xml", and clicking the "Create Project" button
    And I should NOT see a link labeled "Versioning"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see "Versioning - v0.0.0"

    When I click on the button labeled "View available modules"
    Then I should see "Versioning - v0.0.0"
    And I should see "Discoverable"
    And I click on the button labeled Enable for the external module named "Versioning - v0.0.0"
    Then I should see "Versioning - v0.0.0"
    And I logout

  Scenario: E.122.500 - Hide this module from non-admins in the list of enabled modules on each project
    #  Enable 'Hide this module from non-admins in the list of enabled modules on each project'
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled exactly "Manage"
    Then I should see "Versioning - v0.0.0"
    And I should see "Discoverable"
    When I click on the button labeled exactly "Configure"
    And I uncheck the checkbox labeled "Make module discoverable by users"
    And I uncheck the checkbox labeled "Allow non-admins to enable this module on projects"
    And I check the checkbox labeled "Hide this module from non-admins in the list of enabled modules on each project"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"
    And I should NOT see "Discoverable"

    When I create a new project named "E.122.100.500" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_nodata.xml", and clicking the "Create Project" button
    
    # Enable external module
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Versioning - v0.0.0"
    Then I should see "Versioning - v0.0.0"

    # Add User Test_User1 with Project Setup & Design User Rights
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I check the User Right named "Project Setup & Design"
    And I click on the button labeled "Add user"
    Then I should see "successfully added"
    And I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.122.100.500"
    And I should see a link labeled "Versioning"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see "Versioning - v0.0.0"
    And I logout

    # Disable 'Hide this module from non-admins in the list of enabled modules on each project'
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled exactly "Manage"
    Then I should see "Versioning - v0.0.0"
    When I click on the button labeled exactly "Configure"
    And I uncheck the checkbox labeled "Hide this module from non-admins in the list of enabled modules on each project"
    And I click on the button labeled "Save"
    Then I should see "Versioning - v0.0.0"
    And I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.122.100.500"
    And I should see a link labeled "Versioning"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Versioning - v0.0.0"
    And I logout

    # Enable from project - 'Hide this module from non-admins in the list of enabled modules on each project'
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.122.100.500"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    Then I should see "Versioning - v0.0.0"
    When I click on the button labeled exactly "Configure"
    And I check the checkbox labeled "Hide this module from non-admins in the list of enabled modules on this project"
    And I enter "crfver" into the input field labeled "Provide the suffix"
    And I enter "1" into the input field labeled "The current crf version"
    And I click on the button labeled "Save"
    Then I should see "Versioning - v0.0.0"
    And I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.122.100.500"
    And I should see a link labeled "Versioning"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should NOT see "Versioning - v0.0.0"
    And I logout

  Scenario: Module configuration permissions in projects
    # Enable - Require Project Setup/Design privilege
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Module Manager"
    And I should see "Versioning - v0.0.0"
    When I click on the button labeled exactly "Configure"
    Then I should see the dropdown field labeled "Module configuration permissions in projects" with the option "Require Project Setup/Design privilege" selected
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"

    When I create a new project named "E.122.100.600" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val_nodata.xml", and clicking the "Create Project" button

    # Enable external module
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    When I click on the button labeled "Enable a module"
    And I click on the button labeled Enable for the external module named "Versioning - v0.0.0"
    Then I should see "Versioning - v0.0.0"

    #VERIFY
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    When I check the User Right named "Project Setup & Design"
    Then I should see a checkbox labeled "Versioning" that is checked
    And I click on the button labeled "Add user"
    Then I should see "successfully added"

    # Enable - Require module-specific user privilege
    When I click on the link labeled "Control Center"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Module Manager"
    And I should see "Versioning - v0.0.0"
    When I click on the button labeled exactly "Configure"
    And I select "Require module-specific user privilege" on the dropdown field labeled "Module configuration permissions in projects"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Versioning - v0.0.0"

    When I click on the link labeled "My Projects"
    And I click on the link labeled "E.122.100.600"

    #VERIFY
    When I click on the link labeled "User Rights"
    And I enter "Test_User2" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    When I check the User Right named "Project Setup & Design"
    Then I should see a checkbox labeled "Versioning" that is unchecked
    And I check the checkbox labeled "Versioning"
    And I click on the button labeled "Add user"
    Then I should see "successfully added"

  Scenario: E.122.600 - View Usage of the external module
    When I click on the link labeled "Control Center"
    And I click on the link labeled exactly "Manage"
    Then I should see "Versioning - v0.0.0"
    When I click on the button labeled "View Usage"
    Then I should see a link labeled "E.122.100.400" in the dialog box
    And I should see a link labeled "E.122.100.500" in the dialog box
    And I should see a link labeled "E.122.100.600" in the dialog box
    # # For Request Activation of project E.122.100.300 which doesn't work in ATS.
    # # Can be checked manually
    # And I should see a link labeled "E.122.100.300" in the dialog box
    When I click on the link labeled "E.122.100.400" in the dialog box
    Then I should see "Project Home"
    And I should see "E.122.100.400"

  Scenario: E.122.100 - Disable external module
    # Disable external module in project E.122.100.400
    Given I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Versioning - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Versioning - v0.0.0"

    # Disable external module in project E.122.100.500
    Given I click on the link labeled "My Projects"
    When I click on the link labeled "E.122.100.500"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Versioning - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Versioning - v0.0.0"

    # Disable external module in project E.122.100.600
    Given I click on the link labeled "My Projects"
    When I click on the link labeled "E.122.100.600"
    And I click on the link labeled exactly "Manage"
    Then I should see "External Modules - Project Module Manager"
    And I should see "Versioning - v0.0.0"
    When I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Versioning - v0.0.0"

    # Disable external module in Control Center
    Given I click on the link labeled "Control Center"
    When I click on the link labeled exactly "Manage"
    Then I should see "Versioning - v0.0.0"
    When I click on the button labeled "View Usage"
    Then I should see "None" in the dialog box
    And I should NOT see "E.122.100.400" in the dialog box
    And I should NOT see "E.122.100.500" in the dialog box
    And I should NOT see "E.122.100.600" in the dialog box
    And I close the dialog box for the external module "Versioning"
    And I click on the button labeled exactly "Disable"
    Then I should see "Disable module?" in the dialog box
    When I click on the button labeled "Disable module" in the dialog box
    Then I should NOT see "Versioning - v0.0.0"
    And I logout

    # Verify no exceptions are thrown in the system
    Given I open Email
    Then I should NOT see an email with subject "REDCap External Module Hook Exception - versioning"