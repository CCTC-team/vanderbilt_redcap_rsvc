Feature: User Interface: The system shall report background process data import errors.

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.1700.100 Download Errors with Background Data Import
     #REDUNDANT Tested in B.3.16.1400
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.1700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "BigDataTestProject.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        Given I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

        Given I click on the link labeled "Data Import Tool"
        When I select "Import as background process (better for large data sets)" on the dropdown field labeled "Choose an import option"
        And I upload a "csv" format file located at "import_files/BigDataTestProjectbadDATA.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        And I should see "File was uploaded and will be processed soon"
        And I click on the button labeled "Close"
        Then I should see a table header and rows containing the following values in a table:
            | Status     | Original Filename              | Records Provided                  |
            | Queued     | BigDataTestProjectbadDATA.csv  | 75 |
        And I wait for background processes to finish
        #Manual: this may take several minutes

        Given I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in a table:
            | Record ID | Form 1 |
            | 1         |        |
            | 3         |        |
            | 5         |        |
            | 6         |        |
        And I should see all records are in an unverified status
        #Manual: note Records were skipped, user receives email with link to the "View background Imports" where they can click the View details button where they can either Download list of all errors or Download records/data that did not import

        #VERIFY
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username            | Action             | List of Data Changes OR Fields Exported |
            | SYSTEM (Test_Admin) | Create Record 3000 | record_id='3000'                        |

        When I click on the button labeled "View Details"
        And I click on the button labeled "Download list of all errors"
        Then I should see a table header and rows containing the following values in the logging table:
            | Record | Variable Name | Value        | Error Message                                                                                                   |
            | 2      | field 1       | Not a number | The value you provided could not be validated because it does not follow the expected format. Please try again. |
            | 4      | field 2       | 3            | The value is not a valid category for field_2                                                                   |
            | 7      | field 1       | 99-3         | The value you provided could not be validated because it does not follow the expected format. Please try again. |

        When I click on the button labeled "Download records/data that did not import"
        Then I should see a table header and rows containing the following values in the logging table:
            | record_id | field 1      | field_2 | field_3                    |
            | 2         | not a number | 1       | Lorem ipsum dolor sit amet |
            | 4         | 44           | 3       | Lorem ipsum dolor sit amet |
            | 7         | 99-3         | 1       | Lorem ipsum dolor sit amet |
#END