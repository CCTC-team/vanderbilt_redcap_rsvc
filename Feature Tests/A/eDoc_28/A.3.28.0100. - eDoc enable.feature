Feature: A.3.28.0100. Control Center: The system shall allow administrators to configure local or external file storage solutions for REDCap uploads (e.g., Local, Amazon S3, Google Cloud Storage, Microsoft Azure Blob Storage, WebDAV).
As a REDCap administrator   

 I want to verify that the File Upload Settings allow for local file storage   
 So that uploaded PDF snapshots are correctly saved and retrievable 

#IMPLEMENTATION NOTE: This requirement supports multiple REDCap file storage configuration options: 
## Local, Microsoft Azure Blob Storage, Amazon S3, Google Cloud Storage, and WebDAV. 
## Each method is tested in its own scenario. 
## Sites should only run the scenarios relevant to their environment. 
## REDCap does not confirm external file receipt; verification of external storage must be done at the site level (D). 

  Scenario: A.3.28.0100.0100. Configure Local File Storage
# Default REDCap configuration storing files in /edocs/ or another local path. No external setup or credentials required. 
      #SETUP 
    Given I log in to REDCap with the user "Test_Admin"
    And I navigate to the "Control Center"
    And I click the link labeled "File Upload Settings"
    Then I should see the option "Set Local File Storage Location"
   #ACTION: Leave the storage path blank (use default /edocs/) 
    When I leave the local storage path blank
    And I click on the button labeled "Save Changes"
    Then I should see the message "Your configuration values have now been changed"
#SETUP: Create project and complete consent form to generate file 
    When I create a new project named "A.3.28.0100.100" by clicking "New Project", selecting "Practice / Just for fun", uploading file "24ConsentWithSetup.xml", and clicking "Create Project"
    And I click the link labeled "Add/Edit Records"
    And I click the button labeled "Add new record for the arm selected above"
    And I click the bubble labeled "Participant Consent" for event "Event 1"
    Then I should see "Adding new Record ID 1"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastName" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "Email"
    And I enter "2000-01-01" into the input field labeled "DOB"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    And I draw a signature in the "Participant signature field"
    And I click the button labeled "Submit"
    Then I should see "Close survey"
    When I click the button labeled "Close survey"
    And I click the button labeled "Leave without saving changes"
      #VERIFY_RSD 
    Then I should see "Record Home Page"
    And I should see the "Completed Survey Response" icon for "Participant Consent" for event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    Then I should see a table with a PDF snapshot for Record ID 1
    When I click the link in the "PDF Survey Archive"
    And I click the link to view the PDF for Record ID 1
    Then I should have a PDF file with header containing "PID xxxx - LastName"
    And the footer should contain "Type: Participant"
      #Manual: Close document 
#VERIFY Confirm file exists in local server directory 
 # FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Given I completed scenario A.3.28.0100.0100
    Then I confirm that a PDF file corresponding to Record ID 1 exists in the local storage path

  Scenario: A.3.28.0100.0200 – Configure Microsoft Azure Blob Storage
# Requires Azure storage account name, key, container, and environment. Site must confirm that uploaded files are routed to the Azure container. 
#SETUP 
    Given I navigate to the "Control Center"
    And I click the link labeled "File Upload Settings"
    Then I should see the option "Microsoft Azure Blob Storage"
#ACTION: Configure Azure Blob Storage When I select "Microsoft Azure Blob Storage" from the storage options And I enter the following values: | Azure storage account name | [Azure_Account_Name] | | Azure storage account key | [Azure_Account_Key] | | Azure blob container name | [Azure_Container] | And I select "Azure Commercial/Global" from the dropdown labeled "Azure environment"  
    And I click the button labeled "Save Changes"
    Then I should see the message "Your configuration values have now been changed"
#SETUP: Create project and complete consent form to generate file 
    When I create a new project named "A.3.28.0100.100" by clicking "New Project", selecting "Practice / Just for fun", uploading file "24ConsentWithSetup.xml", and clicking "Create Project"
    And I click the link labeled "Add/Edit Records"
    And I click the button labeled "Add new record for the arm selected above"
    And I click the bubble labeled "Participant Consent" for event "Event 1"
    Then I should see "Adding new Record ID 1"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastName" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "Email"
    And I enter "2000-01-01" into the input field labeled "DOB"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    And I draw a signature in the "Participant signature field"
    And I click the button labeled "Submit"
    Then I should see "Close survey"
    When I click the button labeled "Close survey"
    And I click the button labeled "Leave without saving changes"
      #VERIFY_RSD 
    Then I should see "Record Home Page"
    And I should see the "Completed Survey Response" icon for "Participant Consent" for event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    Then I should see a table with a PDF snapshot for Record ID 1
    When I click the link in the "PDF Survey Archive"
    And I click the link to view the PDF for Record ID 1
    Then I should have a PDF file with header containing "PID xxxx - LastName"
    And the footer should contain "Type: Participant"
      #Manual: Close document 
 #VERIFY Confirm file exists in Azure Blob Storage 
 # Site must verify that the PDF file was saved in the configured Microsoft Azure Blob Storage container 
   # FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Given I completed scenario A.3.28.0100.0200
    Then I confirm that a PDF file corresponding to Record ID 1 exists in the specified Azure Blob container

  Scenario: A.3.28.0100.0300 – Configure Amazon S3 Storage
# Requires AWS access key, secret key, bucket name, and region. # Site must verify file appearance in the configured S3 bucket. 
#SETUP: Create project and complete consent form to generate file 
    When I create a new project named "A.3.28.0100.100" by clicking "New Project", selecting "Practice / Just for fun", uploading file "24ConsentWithSetup.xml", and clicking "Create Project"
    And I click the link labeled "Add/Edit Records"
    And I click the button labeled "Add new record for the arm selected above"
    And I click the bubble labeled "Participant Consent" for event "Event 1"
    Then I should see "Adding new Record ID 1"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastName" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "Email"
    And I enter "2000-01-01" into the input field labeled "DOB"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    And I draw a signature in the "Participant signature field"
    And I click the button labeled "Submit"
    Then I should see "Close survey"
    When I click the button labeled "Close survey"
    And I click the button labeled "Leave without saving changes"
      #VERIFY_RSD 
    Then I should see "Record Home Page"
    And I should see the "Completed Survey Response" icon for "Participant Consent" for event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    Then I should see a table with a PDF snapshot for Record ID 1
    When I click the link in the "PDF Survey Archive"
    And I click the link to view the PDF for Record ID 1
    Then I should have a PDF file with header containing "PID xxxx - LastName"
    And the footer should contain "Type: Participant"
      #Manual: Close document 
#VERIFY Confirm file exists in Amazon S3 Storage 
# FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Given I completed scenario A.3.28.0100.0300
    Then I confirm that a PDF file corresponding to Record ID 3 exists in the specified Amazon S3 bucket

  Scenario: A.3.28.0100.0400 – Configure Google Cloud Storage
# Supports GCS via API or App Engine configuration. Site must confirm file appears in the correct Google Cloud bucket. 
#SETUP: Create project and complete consent form to generate file 
    When I create a new project named "A.3.28.0100.100" by clicking "New Project", selecting "Practice / Just for fun", uploading file "24ConsentWithSetup.xml", and clicking "Create Project"
    And I click the link labeled "Add/Edit Records"
    And I click the button labeled "Add new record for the arm selected above"
    And I click the bubble labeled "Participant Consent" for event "Event 1"
    Then I should see "Adding new Record ID 1"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastName" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "Email"
    And I enter "2000-01-01" into the input field labeled "DOB"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    And I draw a signature in the "Participant signature field"
    And I click the button labeled "Submit"
    Then I should see "Close survey"
    When I click the button labeled "Close survey"
    And I click the button labeled "Leave without saving changes"
      #VERIFY_RSD 
    Then I should see "Record Home Page"
    And I should see the "Completed Survey Response" icon for "Participant Consent" for event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    Then I should see a table with a PDF snapshot for Record ID 1
    When I click the link in the "PDF Survey Archive"
    And I click the link to view the PDF for Record ID 1
    Then I should have a PDF file with header containing "PID xxxx - LastName"
    And the footer should contain "Type: Participant"
      #Manual: Close document 
#VERIFY Confirm file exists in Google Cloud Storage 
# FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Given I completed scenario A.3.28.0100.0400
    Then I confirm that a PDF file corresponding to Record ID 4 exists in the specified Google Cloud Storage bucket

  Scenario: A.3.28.0100.0500 – Configure WebDAV Storage
# Uses a WebDAV-accessible path preconfigured on the REDCap server. Site must verify storage access and permissions. 
#SETUP: Create project and complete consent form to generate file 
    When I create a new project named "A.3.28.0100.100" by clicking "New Project", selecting "Practice / Just for fun", uploading file "24ConsentWithSetup.xml", and clicking "Create Project"
    And I click the link labeled "Add/Edit Records"
    And I click the button labeled "Add new record for the arm selected above"
    And I click the bubble labeled "Participant Consent" for event "Event 1"
    Then I should see "Adding new Record ID 1"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastName" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "Email"
    And I enter "2000-01-01" into the input field labeled "DOB"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    And I draw a signature in the "Participant signature field"
    And I click the button labeled "Submit"
    Then I should see "Close survey"
    When I click the button labeled "Close survey"
    And I click the button labeled "Leave without saving changes"
      #VERIFY_RSD 
    Then I should see "Record Home Page"
    And I should see the "Completed Survey Response" icon for "Participant Consent" for event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    Then I should see a table with a PDF snapshot for Record ID 1
    When I click the link in the "PDF Survey Archive"
    And I click the link to view the PDF for Record ID 1
    Then I should have a PDF file with header containing "PID xxxx - LastName"
    And the footer should contain "Type: Participant"
      #Manual: Close document 
#VERIFY Confirm file exists in WebDAV storage location 
# FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Given I completed scenario A.3.28.0100.0500
    Then I confirm that a PDF file corresponding to Record ID 5 exists in the configured WebDAV directory

  Scenario: D.3.28.0100.0600. Confirm file exists in configured file storage location (general)

Site must verify that the PDF file was saved in the configured location—whether local, Microsoft Azure Blob Storage, Amazon S3, Google Cloud Storage, or WebDAV. 

#VERIFY Confirm file exists in configured file storage location 
# FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Given I completed one of the following configuration scenarios:
      | Scenario ID                  |
      | A.3.28.0100.0100 (Local)     |
      | A.3.28.0100.0200 (Azure)     |
      | A.3.28.0100.0300 (Amazon S3) |
      | A.3.28.0100.0400 (GCS)       |
      | A.3.28.0100.0500 (WebDAV)    |
    Then I confirm that a PDF file corresponding to the submitted record exists in the designated file storage path, container, bucket, or directory
