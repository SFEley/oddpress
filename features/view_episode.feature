Feature: View Episode
  As a listener
  I want to view a specific episode
  So that I can get all the details
  
Scenario: Page links on index
  Given an episode titled "Zen and the Art of Motorcycle Maintenance"
  When I go to the home page
   And I click "Zen and the Art of Motorcycle Maintenance"
  Then I should be on the view episode page for that episode
  




  
