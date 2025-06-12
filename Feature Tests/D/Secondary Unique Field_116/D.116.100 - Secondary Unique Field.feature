
Feature: D.116.100 - The system shall provide the ability to enable/disable secondary unique field 

  As a REDCap end user
  I want to see that a secondary field can be made unique or otherwise as expected.

  Scenario: D.116.100 - Enable Secondary Unique Field
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "D.116.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button
   
    Given I click on the link labeled "Designer"
    And I click on the instrument labeled "Text Validation"
    And I click on the first button labeled "Add Field"
    When I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "secondary_id" into the Variable Name of the open "Add New Field" dialog box
    And I enter "Secondary ID" into the Field Label of the open "Add New Field" dialog box
    Then I click on the button labeled "Save"

    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I enter "1" into the data entry form field labeled "Secondary ID"
    Then I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "successfully edited"

    And I click on the link labeled "Project Setup"
    When I click on the button labeled "Additional customizations"
    And I check the checkbox labeled "Designate a Secondary Unique Field"
    
    And I select "secondary_id - Secondary ID" on the dropdown field labeled "Designate a Secondary Unique Field"
    Then I should see a checkbox labeled "Display the value of the Secondary Unique Field next to each record name displayed?" that is checked
    And I should see a checkbox labeled "Display the field label of the Secondary Unique Field when displaying the value?" that is checked
    And I check the checkbox labeled "PDF Customizations"
    And I should see the dropdown field labeled "3)" with the option 'Keep it displayed' selected
    And I click on the button labeled "Save"
    Then I should see "Success! Your changes have been saved"

    #VERIFY_LOG: Logging Table
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Make project customizations             |

    ##VERIFY D.116.200
    Given I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID          |
      | 1 (Secondary ID 1) |

    ##VERIFY D.116.400
    And I click on the link labeled exactly "1"
    When I click on the button labeled "Choose action for record"
    And I click on the link labeled "Download PDF of record data for all instruments/events"
    Then I should see a downloaded file named "D116100_yyyy_mm_dd_hhmm.pdf"
    Then I should see the following values in the downloaded PDF
      | Record ID 1 (Secondary ID 1) (Event 1) |
    
    ##VERIFY D.116.300
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID          |
      | 1 (Secondary ID 1) |

    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Additional customizations"
    And I uncheck the checkbox labeled "Display the field label of the Secondary Unique Field when displaying the value?"
    And I click on the button labeled "Save"
    Then I should see "Success! Your changes have been saved"

    Given I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1 (1)     |

    And I click on the link labeled exactly "1"
    When I click on the button labeled "Choose action for record"
    And I click on the link labeled "Download PDF of record data for all instruments/events"
    Then I should see a downloaded file named "D116100_yyyy_mm_dd_hhmm.pdf"
    Then I should see the following values in the downloaded PDF
      | Record ID 1 (1) (Event 1) |
    
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID |
      | 1 (1)     |

    # Secondary Unique Field should not have duplicate values
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Add new record for this arm"
    When I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I enter "1" into the data entry form field labeled "Secondary ID"
    Then I should see "DUPLICATE VALUE!" in the dialog box
    And I click on the button labeled "Close" in the dialog box
    And I clear field and enter "2" into the input field labeled "Secondary ID"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "successfully added"

    Given I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1 (1)     |
      | 2 (2)     |

    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Additional customizations"
    Then I uncheck the checkbox labeled "Display the value of the Secondary Unique Field next to each record name displayed?"
    And I click on the button labeled "Save"
    Then I should see "Success! Your changes have been saved"
    
    Given I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1         |
      | 2         |

    And I click on the link labeled exactly "1"
    When I click on the button labeled "Choose action for record"
    And I click on the link labeled "Download PDF of record data for all instruments/events"
    Then I should see a downloaded file named "D116100_yyyy_mm_dd_hhmm.pdf"
    Then I should see the following values in the downloaded PDF
      | Record ID 1 (Event 1) |

    Given I click on the link labeled "Data Exports, Reports, and Stats"
    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID |
      | 1         |
      | 2         |

    And I click on the link labeled "Project Setup"
    When I click on the button labeled "Additional customizations"
    Then I check the checkbox labeled "Display the value of the Secondary Unique Field next to each record name displayed?"
    Then I check the checkbox labeled "PDF Customizations"
    And I select "Hide it" on the dropdown field labeled "3)"
    And I click on the button labeled "Save"
    Then I should see "Success! Your changes have been saved"

    Given I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1 (1)     |
      | 2 (2)     |

    And I click on the link labeled exactly "1"
    When I click on the button labeled "Choose action for record"
    And I click on the link labeled "Download PDF of record data for all instruments/events"
    Then I should see a downloaded file named "D116100_yyyy_mm_dd_hhmm.pdf"
    Then I should see the following values in the downloaded PDF
      | Record ID 1 (Event 1) |

    Given I click on the link labeled "Data Exports, Reports, and Stats"
    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID |
      | 1 (1)     |
      | 2 (2)     |

  Scenario: Diasble Secondary Unique Field
    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Additional customizations"
    Then I uncheck the checkbox labeled "Designate a Secondary Unique Field"
    And I click on the button labeled "Save"
    Then I should see "Success! Your changes have been saved"

    Given I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Add new record for this arm"
    When I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I enter "2" into the data entry form field labeled "Secondary ID"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "successfully added"

    Given I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1         |
      | 2         |
      | 3         |
      
    And I logout