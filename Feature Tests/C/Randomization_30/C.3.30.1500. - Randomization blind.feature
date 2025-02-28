Feature: User Interface: The system shall support blinded and open randomization models, with access to allocation details based on user permissions and model setup.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

Scenario: C.3.30.1500.0100. For a blinded model, users without setup rights will see only a concealed allocation code in the record and reports, with no visible group assignment.  

Scenario: C.3.30.1500.0200. For an open model, users without setup rights can view the assigned group allocation directly in the record and reports.  

Scenario: C.3.30.1500.0300. All users with export rights can export randomized records, seeing the allocation assigned to each record as displayed in the record view.  

Scenario: C.3.30.1500.0400. Only users with setup rights or admin privileges can access and export the full allocation table directly from the setup interface, regardless of model type.

Given The above functional requirement has not been written and tested, this functional requirement fail.
Given The above scenarios are completed before removing this line, which causes this feature to correctly fail automation until it is complete