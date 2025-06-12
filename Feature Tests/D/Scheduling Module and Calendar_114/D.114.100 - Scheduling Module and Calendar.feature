Feature: D.114.100  Scheduling Module and Calendar Scheduling

  As a REDCap end user I want to see that Calendar and Scheduling Module works as expected

  Scenario: The system shall support the ability to schedule events
    Given I login to REDCap with the user "Test_User1"
    When I create a new project named "D.114.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/D114100.xml", and clicking the "Create Project" button
    Then I should see a button labeled "Disable" in the "Scheduling module" row in the "Enable optional modules and customizations" section
    And I click on the button labeled "Define My Events"
    Then I should see "Event 1" in the define events table
    
    Then I click on the Edit image for the event named "Event 2"
    And I enter "1" into the Min Offset Range for the event named "Event 2" in the Event table
    And I enter "2" into the Max Offset Range for the event named "Event 2" in the Event table
    And I click on the button labeled "Save"
    Then I should see "Event 2" in the define events table

    Then I click on the Edit image for the event named "Event Three"
    And I enter "1" into the Min Offset Range for the event named "Event Three" in the Event table
    And I enter "2" into the Max Offset Range for the event named "Event Three" in the Event table
    And I enter "[complete_study_date]" into the Custom Event Label for the event named "Event Three" in the Event table
    And I click on the button labeled "Save"

    Then I should see a table header and rows containing the following values in the define events table:
      | Event # | Days Offset | Offset Range | Event Label | Custom Event Label    | Unique event name (auto generated) [event-name] |
      | 1       | 1           | -0/+0        | Event 1     |                       | event_1_arm_1                                   |
      | 2       | 2           | -1/+2        | Event 2     |                       | event_2_arm_1                                   |
      | 3       | 3           | -1/+2        | Event Three | [complete_study_date] | event_three_arm_1                               |

    # Upload Instrument-Event mappings
    Given I click on the tab labeled "Designate Instruments for My Events"
    When I click on the button labeled "Upload or download instrument mappings"
    And I click on the link labeled "Upload instrument-event mappings (CSV)"
    And I upload a "csv" format file located at "import_files/redcap_val/D114100_InstrumentDesignations.csv", by clicking the button near "Select your CSV File of Instrument-Event Designations" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see a dialog containing the following text: "Upload instrument-event mappings (CSV)"
    And I click on the button labeled "Upload" in the dialog box
    # Then I should see a dialog containing the following text: "SUCCESS!"
    And I click on the button labeled "Close" in the dialog box
    Then I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event 1"
    And I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 1"
    And I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 2"
    And I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event Three"

    # Download Instrument-Event mappings
    When I click on the button labeled "Upload or download instrument mappings"
    And I click on the link labeled "Download instrument-event mappings (CSV)"
    Then I should see the latest downloaded "csv" file containing the headings and rows below
        | arm_num | unique_event_name | form            |
        | 1       | event_1_arm_1     | text_validation |
        | 1       | event_1_arm_1     | data_types      |
        | 1       | event_2_arm_1     | data_types      |
        | 1       | event_three_arm_1 | text_validation |           
            
    Given I click on the link labeled "Scheduling"
    And I clear field and enter "11/20/2023" into the input field labeled "Start Date:"
    And I click on the link labeled exactly "20"
    And I click on the button labeled "Generate Schedule"
    Then I should see 'Projected Schedule for "1"'
    When I click on the button labeled "Create Schedule"
    Then I should see 'Successfully Scheduled "1"'
    And I should see a table header and rows containing the following values in a table:
      | Time | Date                 | Event Name  |
      |      | 11/21/2023 Tuesday   | Event 1     |
      |      | 11/22/2023 Wednesday | Event 2     |
      |      | 11/23/2023 Thursday  | Event Three |

    And I click on the tab "View or Edit Schedule"
    And I select "1" on the dropdown field labeled "Select a previously scheduled Record ID:"
    Then I should see 'View/Edit Existing Schedule'
    And I should see a table header and rows containing the following values in a table:
      | Time | Date / Day of Week                                  | Event Name  | Status   | Notes |
      |      | 11/21/2023 Tuesday                                  | Event 1     | Due Date |       |
      |      | 11/22/2023 Wednesday Range: 11/21/2023 - 11/24/2023 | Event 2     | Due Date |       |
      |      | 11/23/2023 Thursday Range: 11/22/2023 - 11/25/2023  | Event Three | Due Date |       |

    # # D.114.200 - Edit calendar event in the Schedule Events - adjust ALL dates
    When I click on the Edit icon for the event named "Event 2" in the Schedule Events
    And I enter "10:00" into the Time for the event named "Event 2" in the Schedule table
    And I click on the button labeled "Done"
    Then I enter "11/23/2023" into the Date for the event named "Event 2" in the Schedule table
    And I click on the link labeled exactly "23"
    Then I enter "Notes Event 2" into the Notes for the event named "Event 2" in the Schedule table
    And I click on the button labeled "Save"
    When I click on the button labeled "YES, adjust ALL dates" in the dialog box
    Then I should see a table header and rows containing the following values in a table:
      | Time     | Date / Day of Week                                  | Event Name  | Status   | Notes         |
      |          | 11/21/2023 Tuesday                                  | Event 1     | Due Date |               |
      | 10:00 am | 11/23/2023 Thursday Range: 11/21/2023 - 11/24/2023  | Event 2     | Due Date | Notes Event 2 |
      |          | 11/24/2023 Friday Range: 11/22/2023 - 11/25/2023    | Event Three | Due Date |               |
  
    # # D.114.200 - Edit calendar event in the Schedule Events - adjust just this one
    When I click on the Edit icon for the event named "Event 2" in the Schedule Events
    Then I enter "11/22/2023" into the Date for the event named "Event 2" in the Schedule table
    And I click on the link labeled exactly "22"
    And I click on the button labeled "Save"
    When I click on the button labeled "NO, just this one" in the dialog box
    Then I should see a table header and rows containing the following values in a table:
      | Time     | Date / Day of Week                                   | Event Name  | Status   | Notes         |
      |          | 11/21/2023 Tuesday                                   | Event 1     | Due Date |               |
      | 10:00 am | 11/22/2023 Wednesday Range: 11/21/2023 - 11/24/2023  | Event 2     | Due Date | Notes Event 2 |
      |          | 11/24/2023 Friday Range: 11/22/2023 - 11/25/2023     | Event Three | Due Date |               |
    
    # D.114.400 - Add Ad Hoc calendar event in the Schedule Events
    When I clear field and enter "11/27/2023" into the input field labeled "Add new Ad Hoc calendar event on"
    And I click on the link labeled exactly "27"
    And I click on the button labeled "Add" to add an Ad Hoc Event
    And I enter "09:00" into the input field labeled "Time"
    And I click on the button labeled "Done"
    And I enter "Ad Hoc Notes" into the textarea field labeled "Notes"
    And I click on the button labeled "Add Calendar Event"
    Then I should see "Your new calendar event was created and added to the calendar!"
    And I return to the REDCap page I opened the calendar event from
    Then I should see a table header and rows containing the following values in a table:
      | Time     | Date / Day of Week                                   | Event Name  | Status   | Notes         |
      |          | 11/21/2023 Tuesday                                   | Event 1     | Due Date |               |
      | 10:00 am | 11/22/2023 Wednesday Range: 11/21/2023 - 11/24/2023  | Event 2     | Due Date | Notes Event 2 |
      |          | 11/24/2023 Friday Range: 11/22/2023 - 11/25/2023     | Event Three | Due Date |               |
      |  9:00 am | 11/27/2023 Monday                                    | Ad Hoc      |          | Ad Hoc Notes  |
    
    # D.114.500 - Delete calendar event in the Schedule Events
    And I click on the Delete icon for the event named "Event Three" in the Schedule Events
    Then I should see "The calendar event has been deleted" in the dialog box
    And I click on the button labeled "Close" in the dialog box
    Then I should NOT see "Event Three"
   
    Given I click on the View icon for the event named "Event 2" in the Schedule Events
    Then I should see "View/Edit Calendar Event"
    And I should see "Notes Event 2"
    When I click on the link labeled "change status"
    And I select "Confirmed" on the dropdown field labeled "Status"
    And I click on the button labeled "Save Status"
    Then I should see "Confirmed"

    # D.114.200 - re-schedule event
    Given I click on the link labeled "View Schedule" in the View Calendar Event
    And I click on the View icon for the event named "Ad Hoc" in the Schedule Events
    When I click on the link labeled "change date"
    And I clear field and enter "11/28/2023" into the input field labeled "Date"
    And I click on the button labeled "Save Date"
    When I click on the link labeled "View Schedule" in the View Calendar Event
    Then I should see 'View/Edit Existing Schedule'
    Then I should see a table header and rows containing the following values in a table:
      | Time     | Date / Day of Week                                   | Event Name  | Status    | Notes         |
      |          | 11/21/2023 Tuesday                                   | Event 1     | Due Date  |               |
      | 10:00 am | 11/22/2023 Wednesday Range: 11/21/2023 - 11/24/2023  | Event 2     | Confirmed | Notes Event 2 |
      |  9:00 am | 11/28/2023 Tuesday                                   | Ad Hoc      |           | Ad Hoc Notes  |

    Given I click on the View icon for the event named "Event 2" in the Schedule Events
    Then I should see "View/Edit Calendar Event"
    And I should see "Notes Event 2"
    When I click on the link labeled "Data Types" in the View Calendar Event
    Then I should see "6" in the data entry form field "Calculated Field"
    And I click on the button labeled "Cancel"

    Given I click on the link labeled "Scheduling"
    And I click on the tab "View or Edit Schedule"
    And I select "1" on the dropdown field labeled "Select a previously scheduled Record ID:"
    Then I should see 'View/Edit Existing Schedule'
    When I click on the View icon for the event named "Event 2" in the Schedule Events
    Then I should see "View/Edit Calendar Event"
    And I should see "Notes Event 2"
    When I click on the link labeled "View Record Home Page" in the View Calendar Event
    Then I should see "Record Home Page"
   
    # D.114.300 - View schedule in calendar
    Given I click on the link labeled "Calendar"
    When I click on the tab labeled "Day"
    Then I should see "No calendar events to display"
    And I select "November" on the Month dropdown field
    When I select "2023" on the Year dropdown field
    And I select "22" on the Day dropdown field
    Then I should see a table header and rows containing the following values in a table:
      | Day         | Time    | Description                  |                                     
      | Wed Nov 22	| 10:00am |	1 (Event 2) - Notes Event 2  |

    When I click on the tab labeled "Week"
    Then I should see a table header and rows containing the following values in a table:
      | Sunday | Monday | Tuesday        | Wednesday                               | Thursday | Friday | Saturday |                                    
      | 19     | 20     |	21 1 (Event 1) | 22 10:00am 1 (Event 2) -  Notes Event 2 | 23       | 24     | 25       | 

    When I click on the tab labeled "Month"
    Then I should see a table header and rows containing the following values in a table:
      | Sunday | Monday | Tuesday                     | Wednesday                               | Thursday | Friday | Saturday |                                    
      | 19     | 20     |	21 1 (Event 1)              | 22 10:00am 1 (Event 2) -  Notes Event 2 | 23       | 24     | 25       | 
      | 26     | 27     |	28 9:00am 1 -  Ad Hoc Notes | 29                                      | 30       |        |          | 
 
    When I click on the tab labeled "Agenda"
    Then I should see a table header and rows containing the following values in a table:
      | Day         | Time    | Description                  |                                     
      | Tue Nov 21	|         | 1 (Event 1)                  |
      | Wed Nov 22	| 10:00am |	1 (Event 2) -  Notes Event 2 |
      | Tue Nov 28	| 9:00am  |	1 -  Ad Hoc Notes            |

    # D.114.500 - Delete calendar event 
    Given I click on the link labeled "Scheduling"
    And I click on the tab "View or Edit Schedule"
    And I select "1" on the dropdown field labeled "Select a previously scheduled Record ID:"
    Then I should see 'View/Edit Existing Schedule'
    When I click on the View icon for the event named "Ad Hoc" in the Schedule Events
    When I should see "View/Edit Calendar Event"
    And I click on the button labeled "Delete from Calendar"
    Then I should see "Your calendar event was successfully deleted!"

    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "D.114.100"
    And I click on the link labeled "Calendar"
    When I click on the tab labeled "Agenda"
    And I select "November" on the Month dropdown field
    And I select "2023" on the Year dropdown field
    Then I should see a table header and rows containing the following values in a table:
      | Day         | Time    | Description                  |                                     
      | Tue Nov 21	|         | 1 (Event 1)                  |
      | Wed Nov 22  | 10:00am |	1 (Event 2) -  Notes Event 2 |

    And I should NOT see "1 -  Ad Hoc Notes"

    # D.114.600 - Verify file download to sync to calendar
    When I click on the button labeled "Sync Calendar to External Application"
    And I click on the button labeled "Download ICS file"
    Then I should see a downloaded file named "D114100_CalendarEvents_yyyy_mm_dd_hhmm.ics"
    And I should have the latest downloaded "ics" file with SHA256 hash value "9c4db3c96fb0b617fe4b8576561c62d6bb6150014686dbdc68a18f7492d927c7"
    And I click on the button labeled "Close" in the dialog box
    And I logout