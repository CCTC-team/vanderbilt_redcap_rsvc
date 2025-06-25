Feature: Project Settings: The system shall allow project-level enabling or disabling of external storage for non-e-Consent governed PDF Snapshots containing completed e-Consent responses.
  As a REDCap administrator
  I want to control whether non-e-Consent governed snapshots are stored externally
  So that storage behavior aligns with regulatory and institutional policies

  Scenario: A.3.28.0600.100 Verify default behavior (ON) for new projects
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.3.28.0600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "SnapshotSample.xml", and clicking the "Create Project" button
    #VERIFY default setting ON
    When I click on the link labeled "Edit Project Settings"
    Then I should see "Enabled" selected for the field labeled "Store non-e-Consent governed PDF Snapshots on the External Storage server"

  Scenario: A.3.28.0600.200 Disable External Storage for non-e-Consent governed snapshots
    #ACTION: Disable setting
    When I click on the link labeled "Edit Project Settings"
    And I select "Disabled" from the dropdown labeled "Store non-e-Consent governed PDF Snapshots on the External Storage server"
    And I click on the button labeled "Save Changes"
    Then I should see "Changes have been saved"
    #ACTION: Add a new record with a completed e-Consent
    When I open the instrument labeled "Participant Consent"
    And I enter required values and draw a signature
    And I submit the survey
    Then I should see "Survey completed"
    #VERIFY: Snapshot is stored in File Repository only
    When I click on the link labeled "File Repository"
    Then I should see a PDF snapshot file listed
    #MANUAL: Site administrator confirms the snapshot does NOT appear in external storage location

  Scenario: A.3.28.0600.300 Enable External Storage for non-e-Consent governed snapshots
    #ACTION: Re-enable setting
    When I click on the link labeled "Edit Project Settings"
    And I select "Enabled" from the dropdown labeled "Store non-e-Consent governed PDF Snapshots on the External Storage server"
    And I click on the button labeled "Save Changes"
    Then I should see "Changes have been saved"
    #ACTION: Add another record with a completed e-Consent
    When I open the instrument labeled "Participant Consent"
    And I enter new values and draw a signature
    And I submit the survey
    Then I should see "Survey completed"
    #VERIFY: Snapshot is stored in File Repository
    When I click on the link labeled "File Repository"
    Then I should see a new PDF snapshot listed
    #MANUAL: Site administrator confirms the snapshot also appears in external storage
#END
