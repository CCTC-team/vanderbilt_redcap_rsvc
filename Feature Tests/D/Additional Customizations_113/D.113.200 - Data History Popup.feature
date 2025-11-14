
Feature: D.113.200 - The system shall support the ability to enable/disable Data History Popup for all data collection instruments.

      As a REDCap end user
      I want to see that Data History Popup is functioning as expected

      Scenario: Enable Data History Popup
            Given I login to REDCap with the user "Test_Admin" 
            And I create a new project named "D.113.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

            #ACTION: Enable Data History Popup 
            Given I click on the link labeled "Project Setup"
            And I click on the button labeled "Additional customizations"
            Then I should see a checkbox labeled Enable the Data History popup for all data collection instruments that is checked in additional customizations
            And I click on the button labeled "Cancel" in the dialog box
            
            #VERIFY - Data History Popup entries
            Given I click on the link labeled "Record Status Dashboard"
            When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
            Then I should see a History icon for the field labeled "Name"
            When I click on the History icon for the field labeled "Name"
            Then I should see a table header and row containing the following values in a table:
                  | Date/Time of Change           |
                  | No data exists for this field |

            And I click on the button labeled "Close" in the dialog box
            When I enter "John" into the data entry form field labeled "Name" 
            And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
            And I click on the History icon for the field labeled "Name"
            Then I should see a table header and row containing the following values in a table:
                  | Date/Time of Change | User       | Data Changes Made | 
                  | mm/dd/yyyy hh:mm    | test_admin | John              |

            And I click on the button labeled "Close" in the dialog box
            When I clear field and enter "Joe" into the data entry form field labeled "Name" 
            And I click on the button labeled "Save & Stay"
            And I click on the History icon for the field labeled "Name"
            Then I should see a table header and row containing the following values in a table:
                  | Date/Time of Change | User       | Data Changes Made | 
                  | mm/dd/yyyy hh:mm    | test_admin | John              |
                  | mm/dd/yyyy hh:mm    | test_admin | Joe               |

            And I click on the button labeled "Close" in the dialog box

      Scenario: Disable Data History Popup 
            Given I click on the link labeled "Project Setup"
            And I click on the button labeled "Additional customizations"
            And I uncheck the checkbox labeled Enable the Data History popup for all data collection instruments in additional customizations
            Then I click on the button labeled "Save" in the dialog box
            
            #VERIFY_LOG
            Given I click on the link labeled "Logging"
            Then I should see a table header and row containing the following values in the logging table:
                  | Date / Time      | Username   | Action        | List of Data Changes OR Fields Exported |
                  | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Make project customizations             |
      
            #VERIFY - No Data History icon is present
            Given I click on the link labeled "Record Status Dashboard"
            When I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
            Then I should NOT see a History icon for the field labeled "Name"
            And I logout