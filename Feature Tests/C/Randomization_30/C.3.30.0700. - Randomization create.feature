Feature: User Interface: The system shall ensure users with Randomization Setup can create and modify randomization models while in project development mode.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

Scenario: C.3.30.0700.0100. Disable stratified randomization.  

Scenario: C.3.30.0700.0200. Enable stratified randomization with one stratum.  

Scenario: C.3.30.0700.0300. Enable stratified randomization with up to 14 strata (test all 14).  

Scenario: C.3.30.0700.0400. Randomize by group/site enabled with no option selected.  

Scenario: C.3.30.0700.0500. Randomize by group/site enabled with DAG selected.  

Scenario: C.3.30.0700.0600. Randomize by group/site enabled with an existing field selected.  

Scenario: C.3.30.0700.0700. Choose open randomization dropdown field.  

Scenario: C.3.30.0700.0800. Choose open randomization radio field.  

Scenario: C.3.30.0700.0900. Choose concealed randomization text field.  

Scenario: C.3.30.0700.1000. Save randomization model.  

Scenario: C.3.30.0700.1100. Erase randomization model.  

Scenario: C.3.30.0700.1200. Download example allocation tables (Excel/CSV).  

Scenario: C.3.30.0700.1300. User with Randomization Setup uploads a unique allocation table in DEVELOPMENT status (system prevents duplicate uploads). 

Scenario: C.3.30.0700.1400. User with Randomization Setup downloads the allocation table previously uploaded in DEVELOPMENT.

Scenario: C.3.30.0700.1500. User with Randomization Setup deletes the allocation table previously uploaded in DEVELOPMENT.

Scenario: C.3.30.0700.1600. User with Randomization Setup uploads a unique allocation table in PRODUCTION status (system prevents duplicate uploads).

Scenario: C.3.30.0700.1700. User with Randomization Setup downloads the allocation table previously uploaded in PRODUCTION.

Scenario: C.3.30.0700.1800. Admin deletes the allocation table previously uploaded in PRODUCTION.

Scenario: C.3.30.0700.1900. Admin uploads an additional allocation table in PRODUCTION status.

Given The above functional requirement has not been written and tested, this functional requirement fail.
Given The above scenarios are completed before removing this line, which causes this feature to correctly fail automation until it is complete