Feature: Create Episode
  As a podcaster
  I want to post a new episode
  So that people will hear my beautiful voice
  
  Scenario: View Form
   Given I am a podcaster
    When I go to the homepage
     And I click "New episode"
    Then I should see a form
    
  