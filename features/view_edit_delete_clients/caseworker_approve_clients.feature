Feature: Case Worker viewing client profiles and being able to approve/reject them
  As an ORAM Case Worker
  In order to mark client refugees statuses as approved, rejected, or incomplete
  I want to be able to see a table of all clients and be able to view their individual profiles

Background: Clients in the database and logged in as an Case Worker
  Given the following clients exist:
    | first_name  | last_name   | email                 | password     	  | role					| invitation_accepted_at |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | 'test'                 |
    | George      | Clooney     | george@clooney.com    | oram123         | client			  | 'test'                 |
    | Michael     | Jordan    	| michael@jordan.com    | oram123         | client			  | 'test'                 |
    | Joe         | Bob     	  | joe@bob.com           | oram123         | client			  | 'test'                 |
  
  And I am logged in as the following admin:
    | first_name  | last_name       | email                     | password          | role      |
    | oram        | caseworker     | case_worker321@gmail.com  | oram_case_worker  | employee  |
  
    And the following relations exist:
    | client      | caseworker      |
    | Bryan Adams | oram caseworker |
    | George Clooney | oram caseworker|

Scenario: Case Worker viewing the list of clients
  Given I follow "Clients"
  Then I should see "Bryan"
    And I should see "George"
    And I should not see "Michael"
    And I should not see "Joe"

Scenario: Case Worker trying to mark statuses of clients
  Given I follow "Clients"
  And I view the profile of "Bryan Adams"
  And I press "Approve"
  Then the status of "Bryan Adams" should be "Approved"
  And I view the profile of "George Clooney"
  And I press "Reject"
  Then the status of "George Clooney" should be "Rejected"
  And I view the profile of "Bryan Adams"
  And I press "Incomplete"
  Then the status of "Bryan Adams" should be "Incomplete"

Scenario: Case Worker trying to follow case status of clients
  Given PENDING
  Given I follow "Clients"
  And I view the profile of "Bryan Adams"
  