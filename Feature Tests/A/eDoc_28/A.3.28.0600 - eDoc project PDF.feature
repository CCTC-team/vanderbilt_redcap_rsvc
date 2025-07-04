Feature: Project Settings: The system shall allow project-level enabling or disabling of external storage for non-e-Consent governed PDF Snapshots containing completed e-Consent responses.
  As a REDCap administrator
  I want to control whether non-e-Consent governed snapshots are stored externally
  So that storage behavior aligns with regulatory and institutional policies

  Scenario: A.3.28.0600.100 Verify default behavior (ON) for new projects
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.3.28.0600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
    #VERIFY default setting ON
    When I click on the link labeled "Edit Project Settings"
    Then I should see the dropdown field labeled "Store non-e-Consent governed PDF Snapshots on the External Storage server" with the option "Enabled" selected

  Scenario: A.3.28.0600.200 Disable External Storage for non-e-Consent governed snapshots
    #ACTION: Disable setting
    And I select "Disabled" on the dropdown field labeled "Store non-e-Consent governed PDF Snapshots on the External Storage server"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved"
    #ACTION: Add a new record with a completed e-Consent
    When I click on the link labeled "My Projects"
    And I should see "Listed below are the REDCap projects"
    And I click on the link labeled "A.3.28.0600.100"
    And I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Next Page"
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    #VERIFY: Snapshot is stored in File Repository only
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see "pid13_formParticipantConsent_id1"
    #MANUAL: Site administrator confirms the snapshot does NOT appear in external storage location

  Scenario: A.3.28.0600.300 Enable External Storage for non-e-Consent governed snapshots
    #ACTION: Re-enable setting
    When I click on the link labeled "Setup"
    When I click on the link labeled "Edit Project Settings"
    And I select "Enabled" on the dropdown field labeled "Store non-e-Consent governed PDF Snapshots on the External Storage server"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved"
    #ACTION: Add another record with a completed e-Consent
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.28.0600.100"
    And I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Next Page"
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    #VERIFY: Snapshot is stored in File Repository
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see "pid13_formParticipantConsent_id2"
    #MANUAL: Site administrator confirms the snapshot also appears in external storage
#END
