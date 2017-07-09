@javascript
Feature: Administrator Login Portal
  As a user with administrator access to the ORAM portal
  In order to be able to sign up
  I should be able to lsign up through a link sent to me by an admin

Scenario: Accessing the sign up page
  Given I am on the sign up page
  When I follow "Admin Sign Up"
  Then I should be on the admin sign up page
  And I should see "Log In"

Scenario: Valid administrator signing in
  Given I am on the admin sign page
  Then I should see "Admin Sign Up"
  When I fill in "admin_email" with "admin321@gmail.com"
  When I fill in "admin_password" with "oramadmin"
  And I press "Sign in"
  Then I should not see "Your Email is not valid ot Sign up"
  And I should be on on my landing page

Scenario: Administrator sign up info does not exist
 Given I am on the admin sign up page
 When I fill in "admin_email" with "invalid_email"
 When I fill in "admin_password" with "invalid_password"
 And I press "Sign up"
 Then I should be on the admin sign up page
 Then I should see "IYour Email is not valid ot Sign up"
