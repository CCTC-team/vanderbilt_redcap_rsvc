Feature: D.3.28.0700. The system shall ensure that PDF snapshots stored in the File Repository are saved to the configured file storage location (local or external) as specified in the Control Center settings.
  The system shall ensure that files uploaded to the File Repository are saved in the configured external file storage location.

  As a local REDCap administrator
  I want to verify that files uploaded to the File Repository are stored in our configured external storage solution
  So that I can ensure compliance with institutional storage and retention policies

  This scenario is not executed as part of the centralized consortium validation package.
  Sites must complete this verification independently within their environment.
  #FUNCTIONAL_REQUIREMENT
  #VALIDATION_NOTE

  Scenario: D.3.28.0700.0100. External Storage Verification for File Repository
    #SETUP
    Given your REDCap instance is configured to use an external file storage method
    And the File Repository module is enabled
    #ACTION
    When you upload a file to the File Repository in any project
    #VERIFY
    Then confirm that the uploaded file exists in the configured external storage container or path
    And verify the file name, timestamp, and size match the corresponding metadata in REDCap
    #MANUAL
