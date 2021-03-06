Feature: As a course administrator,
  In order to be able to issue the right certificates for a course,
  I want to display course title, course date and the
  participants name on the certificate


Scenario: Generate a certificate
  Given the delivery for the course "Basic" is set to "2015-12-01"
  And the data file for "2015-12-01" is imported
  And I am on 2015-12-01 show page
  And I click "Generate certificates" link
  Then 3 certificates should be generated
  And 3 images of certificates should be created
  And I should see 3 "view certificate" links
  And I should see "Generated 3 certificates"

Scenario: Certificate generation is disabled if certificates exists
  Given valid certificates exists
  Then I should not see "Generate certificates"

