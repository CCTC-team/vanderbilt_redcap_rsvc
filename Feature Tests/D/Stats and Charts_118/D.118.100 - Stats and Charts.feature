
Feature: Stats and Charts: The system shall support the viewing of stats and charts.

    As a REDCap end user
    I want to see that Stats and Charts is functioning as expected

    Scenario: Stats and Charts.
        Given I login to REDCap with the user "Test_Admin"   
        And I create a new project named "D.118.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "redcap_val/Project_redcap_val.xml", and clicking the "Create Project" button

        #ACTION: Import data 
        Given I click on the link labeled "Data Import Tool"
        And  I upload a "csv" format file located at "import_files/redcap_val/redcap_val_Data_Import.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        And I should see "Your document was uploaded successfully and is ready for review."
        And I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

        #VERIFY_RSD: 15 records
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a link labeled "15"

        ##VERIFY_DE
        When I click on the link labeled "Data Exports, Reports, and Stats"
        And I click on the tab labeled "My Reports & Exports"
        Then I should see a table rows containing the following values in a table:  
            | A | All data (all records and fields)  |
            | B | Selected instruments and/or events |
        
        And I click on the button labeled "Stats & Charts" 
        Then I should see "All data (all records and fields)"

        And I select "Text Validation" on the dropdown field labeled "Select a data collection instrument to view"
        Then I see a table header and rows containing the following values in a table: 
            | Total Count (N) | Missing   |
            | 12              | 3 (20.0%) |

        And I see a table header and rows containing the following values in a table: 
            | Total Count (N) | Missing   |
            | 11              | 4 (26.7%) |

        And I see a table header and rows containing the following values in a table: 
            | Total Count (N) | Missing  | Unique |
            | 15              | 0 (0.0%) | 3      |

        # View Bar Chart
        And I should see the dropdown field labeled "Complete?" with the option "View as Bar Chart" selected
        Then I should see a bar chart for "Complete?" with bar of width 311
        And I should see a bar chart for "Complete?" with bar of width 259
        And I should see a bar chart for "Complete?" with bar of width 207
        # View Pie Chart
        When I select "View as Pie Chart" on the dropdown field labeled "Complete?"
        Then I should see a pie chart for "Complete?" with text "40%"
        And I should see a pie chart for "Complete?" with text "33.3%"
        And I should see a pie chart for "Complete?" with text "26.7%"

        When I select "Data Types" on the dropdown field labeled "Select a data collection instrument to view"
        Then I see a table header and rows containing the following values in a table:  
            | Total Count (N) | Missing   |
            | 13              | 2 (13.3%) |
            
        And I see a table header and rows containing the following values in a table: 
            | Total Count (N) | Missing   |
            | 11              | 4 (26.7%) |

        And I see a table header and rows containing the following values in a table: 
            | Total Count (N) | Missing   | Unique |
            | 12              | 3 (20.0%) | 3      |

        # View Pie Chart
        And I should see the dropdown field labeled "Multiple Choice Dropdown Manual" with the option "View as Bar Chart" selected 
        Then I should see a bar chart for "Multiple Choice Dropdown Manual" with bar of width 155
        And I should see a bar chart for "Multiple Choice Dropdown Manual" with bar of width 363
        And I should see a bar chart for "Multiple Choice Dropdown Manual" with bar of width 103
        # View Pie Chart
        When I select "View as Pie Chart" on the dropdown field labeled "Multiple Choice Dropdown Manual"
        Then I should see a pie chart for "Multiple Choice Dropdown Manual" with text "25%"
        And I should see a pie chart for "Multiple Choice Dropdown Manual" with text "58.3%"
        And I should see a pie chart for "Multiple Choice Dropdown Manual" with text "16.7%"
     
        Then I should NOT see "File Upload" 
        And I see a table header and rows containing the following values in a table: 
            | Total Count (N) | Missing | Unique | Min | Max | Mean | StDev | Sum | Percentile |
       
        And I see a table header and rows containing the following values in a table: 
            | 0.05       | 0.10 | 0.25 | 0.50 Median | 0.75  | 0.90 | 0.95 | 
        
        And I see a table header and rows containing the following values in a table: 
            | 15              | 0 (0.0%) | 1     | 6   | 6   | 6    | 0     | 90  | 6          | 6    | 6    | 6           | 6     | 6    | 6    |
            
        And I should see "Lowest values: 6, 6, 6, 6, 6"
        And I should see "Highest values: 6, 6, 6, 6, 6"
        And I see a table header and rows containing the following values in a table:
            | Total Count (N) | Missing | Unique |
            | 15              | 0 (0.0%) | 3      |

        # View Bar Chart
        And I should see the dropdown field labeled "Complete?" with the option "View as Bar Chart" selected
        Then I should see a bar chart for "Complete?" with bar of width 311
        And I should see a bar chart for "Complete?" with bar of width 259
        And I should see a bar chart for "Complete?" with bar of width 207
        # View Pie Chart
        When I select "View as Pie Chart" on the dropdown field labeled "Complete?"
        Then I should see a pie chart for "Complete?" with text "40%"
        And I should see a pie chart for "Complete?" with text "33.3%"
        And I should see a pie chart for "Complete?" with text "26.7%"
        When I click on the link labeled "4 (26.7%)"
        Then I should see "Missing values: 10, 13, 14, 15"
 
        When I click on the button labeled "Show stats only"
        Then I see a table header and rows containing the following values in a table:  
            | Total Count (N) | Missing   |
            | 13              | 2 (13.3%) |

        And I should see the dropdown field labeled "Multiple Choice Dropdown Manual" with the option "View as Pie Chart" selected
        And I should NOT see a pie chart for "Multiple Choice Dropdown Manual" with text "25%"
                    
        When I click on the button labeled "Show plots only"
        Then I should NOT see "Total Count (N)"
        # View Pie Chart
        And I should see the dropdown field labeled "Multiple Choice Dropdown Manual" with the option "View as Pie Chart" selected
        Then I should see a pie chart for "Multiple Choice Dropdown Manual" with text "25%"
        And I should see a pie chart for "Multiple Choice Dropdown Manual" with text "58.3%"
        And I should see a pie chart for "Multiple Choice Dropdown Manual" with text "16.7%"

        When I click on the button labeled "Show plots & stats"
        Then I see a table header and rows containing the following values in a table:  
            | Total Count (N) | Missing   |
            | 13              | 2 (13.3%) |

        And I should see the dropdown field labeled "Multiple Choice Dropdown Manual" with the option "View as Pie Chart" selected
        And I should see a pie chart for "Multiple Choice Dropdown Manual" with text "25%"
        And I should see a pie chart for "Multiple Choice Dropdown Manual" with text "58.3%"
        And I should see a pie chart for "Multiple Choice Dropdown Manual" with text "16.7%"
        And I logout