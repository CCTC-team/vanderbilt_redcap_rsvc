Feature: Control Center: The system shall allow administrators to configure the availability and maximum file size of ‘File Upload’ fields used in forms and surveys.

  As a REDCap administrator
  I want to manage the behavior of 'File Upload' fields globally
  So that I can control their availability and file size limits

  Scenario: A.3.28.0300.100 Disable 'File Upload' field type globally
    #SETUP
    Given I login to REDCap with the user "Test_Admin"

    #ACTION: Disable File Upload fields
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Disabled" on the dropdown field labeled "Enable 'FILE UPLOAD' FIELD TYPES"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Field type unavailable in Online Designer
    When I navigate to a project and click on the link labeled "Online Designer"
    Then I should NOT see the option "File Upload" in the field type list

    #VERIFY: Existing fields no longer functional
    When I open a form that contains an existing File Upload field
    Then I should see a message or hidden input indicating the field is disabled

  Scenario: A.3.28.0300.200 Enable 'File Upload' field type globally
    #ACTION: Enable File Upload fields
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Enabled" on the dropdown field labeled "Enable 'FILE UPLOAD' FIELD TYPES"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Field type visible in Online Designer
    When I navigate to a project and click on the link labeled "Online Designer"
    Then I should see the option "File Upload" in the field type list

    #VERIFY: Existing fields functional again
    When I open a form that contains an existing File Upload field
    Then I should see the standard file upload interface

  Scenario: A.3.28.0300.300 Enforce max file size for 'File Upload' fields
    #SETUP: Set small file size limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I enter "1" into the field labeled "Upload max file size for 'file' field types on forms/surveys (MB)"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Large file upload blocked
    When I navigate to a form with a File Upload field
    And I attempt to upload a file larger than 1 MB
    Then I should see an error message indicating the file exceeds the allowed size

    #VERIFY: Small file upload succeeds
    When I upload a file smaller than 1 MB
    Then I should see the file name listed in the field