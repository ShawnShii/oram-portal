Feature: Client Profile
  As an approved client
  In order to provide the necessary information to be considered for refugee status
  I want to be able view and edit my profile

Background: Logging in as a client with an account

  Given I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role					|
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  |

Scenario: Client trying to view their profile
  Given PENDING
  Given I follow "Profile"
  Then I should see "Name:"
    And my name should be "Bryan Adams"
    And my email should be "bryan@adams.com"
    
Scenario: Client trying to edit their profile
  Given PENDING
  Given I follow "Profile"
  Then I should see "Settings"
  When I follow "Settings"
  Then I should see "Name:"
    And I should see "E-mail:"
    And I should see "Current password:"
    And I should see "New password:"
    And I should see "Confirm new password"
  When I enter "Brian Adams" in "Name:"
    And I press "Submit"
  Then I should see "Name"
    And I should see "Brian Adams"
    
Scenario: Client trying to delete their profile
  Given I follow "Profile"
  Then I should see "Settings"
  When I follow "Settings"
  Then I should see "Delete"
  When I press "Delete"
  Then I should see "Are you sure?"
    And I should see "OK"
    When I have pressed "OK"
  Then I should be on the home page
