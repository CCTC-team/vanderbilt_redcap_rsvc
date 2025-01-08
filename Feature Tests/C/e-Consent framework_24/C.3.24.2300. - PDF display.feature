Feature: User Interface: The system shall support the hide/unhide active and inactive triggers within PDF Snapshots.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario:  C.3.24.2300.100 hide/unhide active and inactive triggers within PDF Snapshots.

      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      ##ACTION: New Active PDF Trigger
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent and PDF Snapshot"
      And I click on the button labeled "PDF Snapshots of Record"
      And I click on the button labeled "+Add new trigger"
      And I enter "Snapshot" in the box labeled "Name of trigger"
      And I select "'Participant Consent' - [Any EVENT]" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I enter "" into the input field labeled "[All instruments]"
      And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
      And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I check the checkbox labeled "Save to File Repository"
      And I check the checkbox labeled "Save to specified field:"
      And I select "participant_file" on the event name "Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "select a File Upload field" in the dialog box
      And I enter "Custom" into the input field labeled "File name:"
      And I click on the button labeled "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name     | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Enable | Edit Copy     | Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


   Scenario: Copy trigger
      ##ACTION: Copy trigger
      When I click on the button labeled "Copy trigger" for the trigger labeled "Snapshot"
      Then I should see "Do you wish to copy this PDF Snapshot Trigger?"

      When I click on the button labeled "Copy trigger"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name     | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Enable | Edit Copy     | Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Enable | Edit Copy     | Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


   Scenario: Edit trigger
      ##ACTION: Edit trigger
      When I click on the button labeled "Edit trigger" for the trigger labeled "Snapshot"
      And I enter "Hide Snapshot" in the box labeled "Name of trigger"
      And I click on the button labeled "Save"
      Then I should see "Saved! Trigger for PDF Snapshot was successfully modified"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Enable | Edit Copy     | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Enable | Edit Copy     | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

      ##VERIFY_Logging
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
         | Username   | Action        | List of Data Changes OR Fields Exported        |
         | test_admin | Manage/Design | Modify trigger for PDF Snapshot (snapshot_id = |
         | test_admin | Manage/Design | Copy PDF Snapshot Trigger (copy snapshot_id =  |
         | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |

   Scenario: Add record in data survey mode (pdf snapshot created)
      #Add record in data survey mode (pdf snapshot created)
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
      Then I should see "Adding new Record ID 1."

      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I click on the button labeled "Survey options"
      And I click on the survey option label containing "Open survey" label
      Then I should see "Participant Consent"

      When I enter "FirstName" into the input field labeled "First Name"
      And I enter "LastName" into the input field labeled "Last Name"
      And I enter "email@test.edu" into the input field labeled "Email"
      And I enter "2000-01-01" into the input field labeled "DOB"
      And I enter "MyName" into the input field labeled "Participant's Name Typed"
      
        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

      And I click on the button labeled "Save signature" in the dialog box
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"
      And I should see "Incomplete" icon for the Data Collection Instrument labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"

      # Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name       | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
         | Custom.pdf | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
         | Custom.pdf | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |


   Scenario: Cancel Inactivate triggers
      When I click on the button labeled "PDF Snapshots of Record"
      Then I should see a checkbox labeled "Hide inactive" that is checked
      And I should see the pdf snapshot trigger is "Active" for trigger labeled "Hide Snapshot"
      And I should see the pdf snapshot trigger is "Active" for trigger labeled "Snapshot"

      When I "Disable" the pdf snapshot trigger labeled "Hide Snapshot"
      Then I should see "Are you sure you wish to disable this PDF Snapshot Trigger?"

      When I click on the button labeled "Cancel" in the dialog box
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Enable | Edit Copy     | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Enable | Edit Copy     | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


   Scenario: Inactivate triggers
      When I click on the button labeled "PDF Snapshots of Record"
      Then I should see a checkbox labeled "Hide inactive" that is checked
      And I should see the pdf snapshot trigger is "Active" for trigger labeled "Hide Snapshot"
      And I should see the pdf snapshot trigger is "Active" for trigger labeled "Snapshot"

      When I "Disable" the pdf snapshot trigger labeled "Hide Snapshot"
      Then I should see "Are you sure you wish to disable this PDF Snapshot Trigger?"

      When I click on the button labeled "Set to inactive" in the dialog box
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name     | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Enable | Edit Copy     | Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Unhide inactive
      When I uncheck the checkbox labeled "Hide inactive"
      Then I should see a table header and rows containing the following values in a table:
         | Active  | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Enable  | Edit Copy     | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Disable | Edit Copy     | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Inactivate triggers
      When I "Disable" the pdf snapshot trigger labeled "Snapshot"
      Then I should see "Are you sure you wish to disable this PDF Snapshot Trigger?"

      When I click on the button labeled "Set to inactive" in the dialog box
      Then I should see a table header and rows containing the following values in a table:
         | Active  | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Disable | Edit Copy     | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Disable | Edit Copy     | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


   Scenario: Hide inactive
      When I check the checkbox labeled "Hide inactive"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name | Type of trigger | Save snapshot when... | Scope of the snapshot | Location(s) to save the snapshot |


   Scenario: Add record in data survey mode (pdf snapshot NOT created)
      #Add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
      Then I should see "Adding new Record ID 2."

      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I click on the button labeled "Survey options"
      And I click on the survey option label containing "Open survey" label
      Then I should see "Participant Consent"

      When I enter "FirstName" into the input field labeled "First Name"
      And I enter "LastName" into the input field labeled "Last Name"
      And I enter "email@test.edu" into the input field labeled "Email"
      And I enter "2000-01-01" into the input field labeled "DOB"
      And I enter "MyName" into the input field labeled "Participant's Name Typed"
      
        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

      And I click on the button labeled "Save signature" in the dialog box
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"
      And I should see "Incomplete" icon for the Data Collection Instrument labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"

      # Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name       | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
         | Custom.pdf | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
         | Custom.pdf | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
   #I should NOT see Record 2

   Scenario: Reactivate triggers
      When I click on the button lanbeled "Designer"
      And I click on the button labeled "e-Consent and PDF Snapshot"
      And I uncheck the checkbox labeled "Hide inactive"
      Then I should see a table header and rows containing the following values in a table:
         | Active  | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Disable | Edit Copy     | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Disable | Edit Copy     | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


      When I "Enable" the pdf snapshot trigger labeled "Snapshot"
      Then I should see a table header and rows containing the following values in a table:
         | Active  | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Enable  | Edit Copy     | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Disable | Edit Copy     | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Add record in data survey mode (pdf snapshot created)
      #Add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
      Then I should see "Adding new Record ID 3."

      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I click on the button labeled "Survey options"
      And I click on the survey option label containing "Open survey" label
      Then I should see "Participant Consent"

      When I enter "FirstName" into the input field labeled "First Name"
      And I enter "LastName" into the input field labeled "Last Name"
      And I enter "email@test.edu" into the input field labeled "Email"
      And I enter "2000-01-01" into the input field labeled "DOB"
      And I enter "MyName" into the input field labeled "Participant's Name Typed"
      
        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

      And I click on the button labeled "Save signature" in the dialog box
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"
      And I should see "Incomplete" icon for the Data Collection Instrument labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"

      # Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name       | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
         | Custom.pdf | -                                | 3      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
         | Custom.pdf | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
         | Custom.pdf | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
#I should NOT see Record 2
#END