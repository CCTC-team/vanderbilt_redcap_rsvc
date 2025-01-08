Feature: Field Creation: The system shall support the creation and spliting matrix of fields

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.2000.100 Matrix of Fields through the Online Designer

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        When I click on the link labeled "New Project"
        And I enter "B.6.7.2000.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"

        ##SETUP_PRODUCTION
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.6.7.2000.100"
        And I click on the button labeled "Online Designer"


        #FUNCTIONAL_REQUIREMENT
        ##ACTION: matrix fields creation
        When I click on the instrument labeled "Form 1"
        And I click on the button labeled "Add Matrix of Fields"
        And I enter "Vanilla" into the input field labeled "Field Label"
        And I enter "flavor1" into the input field labeled "Variable Name"
        And I click on the button labeled "Add another row"
        And I enter "Chocolate" into the input field labeled "Field Label"
        And I enter "flavor2" into the input field labeled "Variable Name"
        And I click on the button labeled "Add another row"
        And I enter "Strawberry" into the input field labeled "Field Label"
        And I enter "flavor3" into the input field labeled "Variable Name"
        And I click on the button labeled "Add another row"

        And I click on the first button labeled "Add Matrix of Fields"
        And I enter Choices of "1, Checkbox1" into the open "Add New Field" dialog box
        And I enter Choices of "2, Checkbox2" into the open "Add New Field" dialog box
        And I enter Choices of "3, Checkbox3" into the open "Add New Field" dialog box
        And I enter Choices of "1, Dislike" into the open "Add New Field" dialog box
        And I enter Choices of "2, Neutral" into the open "Add New Field" dialog box
        And I enter Choices of "3, Love" into the open "Add New Field" dialog box
        And I enter "ice_cream" into the input field labeled "Matrix group name"
        And I click on the button labeled "Save"
        Then I should see the field labeled "Matrix Group: ice_cream"
        And I should see a table header and rows containing the following values in the browse users table:
            | Dislike | Neutral | Love |

        ##VERIFY_LOGGING
        When I click on the link labeled "Logging"
        Then I should see "Create matrix of fields"

        #VERIFY: SPLIT OF MATRIX
        When I click on the link labeled "Designer"  
        And I click on the instrument labeled "Form 1"
        When I click on the icon labeled "Edit Matrix" on the field labeled "Matrix Group: ice_cream"
        And I click on the button labeled "Save & split into separate fields"
        And I click on the button labeled "Split matrix"
        Then I should see the field labeled "Vanilla"
        And I should see the field labeled "Chocolate"
        And I should see the field labeled "Strawberry"

        ##VERIFY_LOGGING
        When I click on the link labeled "Logging"
        Then I should see "Edit matrix of fields"
#END