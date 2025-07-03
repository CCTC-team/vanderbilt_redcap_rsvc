Feature: Control Center: The system shall allow administrators to configure upload behavior for general attachments used in Descriptive fields and Data Resolution Workflow (DRW).

  As a REDCap administrator
  I want to manage upload permissions and file size limits for general attachments
  So that I can ensure appropriate file handling in descriptive content and query responses

  Scenario: A.3.28.0500.100 Disable general file attachments
    #SETUP
    Given I login to REDCap with the user "Test_Admin"

    #ACTION: Disable general attachments
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    When I select "Disabled" on the dropdown field labeled "Allow file attachments to be uploaded for data queries in the Data Resolution Workflow"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Upload blocked in DRW
    And I create a new project named "A.3.28.0500" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    And I click on the button labeled "Additional customizations"
    When I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
    And I click on the button labeled "Save"
    And I click on the button labeled "Close"
    
    Given I click on the link labeled "Add / Edit Records"
    Given I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
    And I click on the radio labeled "Open query"
    And I enter "My comment" into the textarea field labeled "Comment"
    And I click on the button labeled "Open query"
    And I click on the link labeled "Resolve Issues"
    And I click on the button labeled "1 comment" in the row labeled "Name"
    Then I should NOT see the option to attach a file

  Scenario: A.3.28.0500.200 Enable general file attachments with file size limit
    #SETUP: Enable with limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I set the value "2" in the field labeled "Upload max file size for general file attachments (MB)"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Successful upload in Descriptive field
    When I navigate to a project and upload a file smaller than 2 MB in a Descriptive field
    Then I should see the file name and a confirmation of upload

    #VERIFY: Upload fails if file exceeds limit
    When I attempt to upload a file larger than 2 MB in a Descriptive field
    Then I should see an error message indicating the file exceeds the allowed size

    #VERIFY: Upload and view in DRW
    When I respond to a data query and attach a file smaller than 2 MB
    Then I should see the file attached in the query response

#END
