Feature: Referring a client for refugee status
As an approved referrer for ORAM
In order to refer someone I know for refugee status
I want to be able to fill out a form to refer a client

Background: Referrer in the database
  Given I am logged in as the following referrer:
    | first_name  | last_name   | email                 | password     	  | role					|
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | referrer			|

Scenario: Referring a client correctly
	Given I should see "ORAM Website"
	Given I should see "Refer Client"
  Given I follow "Refer Client"
  And I complete the client referral form
  And I press "Submit"
	Then I should see "First Name:"
#  Then I should see "Client has been successfully referred"

# Scenario: Filling out an empty form
#	Given I follow "Refer Client"
#	And I press "Submit"
#	Then I should see "Cannot submit an incomplete form"
