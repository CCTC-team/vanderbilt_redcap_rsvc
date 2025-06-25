Feature: Control Center: The system shall allow administrators to configure upload behavior for Send-It, including enabling/disabling the feature and enforcing file size limits.

  As a REDCap administrator
  I want to control Send-It upload availability and limits
  So that I can ensure secure file transfers comply with institutional policies

  Scenario: A.3.28.0400.100 Disable Send-It uploads globally
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Disabled" on the dropdown field labeled "Enable Send-It"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    When I click on the link labeled "Send-It"
    Then I should see a message stating "The Send-It feature is currently disabled by an administrator."

  Scenario: A.3.28.0400.200 Enable Send-It uploads
    Given I am logged in as "Test_Admin"
    When I navigate to "Control Center > File Upload Settings"
    And I select "Enabled for all locations" from the dropdown labeled "Enable Send-It"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    When I click on the link labeled "Send-It"
    Then I should see the Send-It upload interface

  Scenario: A.3.28.0400.300 Block large Send-It file uploads over limit
    Given I am in the "File Upload Settings" page
    When I enter "1" into the field labeled "Send-It upload max file size (MB)"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    When I attempt to upload a file larger than 1 MB through Send-It
    Then I should see an error message indicating the file exceeds the allowed size

  Scenario: A.3.28.0400.400 Allow Send-It upload below size limit
    When I upload a file smaller than 1 MB using the Send-It interface
    Then I should see a confirmation message indicating the file was successfully uploaded and shared