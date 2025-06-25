Feature: Control Center: The system shall allow administrators to configure the File Repository, including upload permissions, file size and storage limits, and public link sharing (tested in A.3.26.0100.100).

  As a REDCap administrator
  I want to control the upload behavior and limits of the File Repository module
  So that I can enforce institutional data storage policies

  # NOTE: Public link behavior is tested in A.3.26.0100.100 and not re-tested here.

  Scenario: A.3.28.0200.100 Disable manual uploads to the File Repository
    #SETUP
    Given I login to REDCap with the user "Test_Admin"

    #ACTION: Disable File Repository
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Disabled" on the dropdown field labeled "Enable file uploading for the File Repository module"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Upload interface not visible
    When I navigate to any project and click on the link labeled "File Repository"
    Then I should NOT see the button labeled "Select files to upload"

  Scenario: A.3.28.0200.200 Enable manual uploads to the File Repository
    #ACTION: Enable File Repository
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Enabled" on the dropdown field labeled "Enable file uploading for the File Repository module"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Upload interface is visible and functional
    When I navigate to a project and click on the link labeled "File Repository"
    Then I should see the button labeled "Select files to upload"
    When I upload the file "import_files/testusers_bulkupload.csv"
    Then I should see the file name in the File Repository table

  Scenario: A.3.28.0200.300 Enforce max file size for uploads to File Repository
    #SETUP: Set small file size limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I enter "1" into the field labeled "File Repository upload max file size (MB)"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Blocked upload for large file
    When I attempt to upload a file larger than 1 MB to the File Repository
    Then I should see an error message indicating file exceeds allowed size

    #VERIFY: Successful upload for small file
    When I upload a file smaller than 1 MB
    Then I should see the file name in the File Repository table

  Scenario: A.3.28.0200.400 Enforce per-project storage limit
    #SETUP: Set low project storage limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I enter "2" into the field labeled "File Repository: File storage limit (MB) for all projects"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #ACTION: Upload until limit reached
    When I navigate to a project File Repository
    And I upload files totaling 2 MB

    #VERIFY: Upload blocked beyond limit
    When I attempt to upload one more file
    Then I should see an error message about exceeding the storage limit
