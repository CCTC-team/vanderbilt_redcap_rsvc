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
    And I set the value "0" in the field labeled "Upload max file size for general file attachments (MB)"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Upload blocked in Descriptive field
    When I navigate to a project and access a Descriptive field with an attachment upload option
    Then I should NOT see an upload option in that field

    #VERIFY: Upload blocked in DRW
    When I respond to an open query in the Data Resolution Workflow
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
