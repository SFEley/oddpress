Feature: View Episode
  As a listener
  I want to view a specific episode
  So that I can get all the details
  
Scenario: Page links on index
  Given an episode titled "Zen and the Art of Motorcycle Maintenance"
  When I go to the home page
   And I click "Zen and the Art of Motorcycle Maintenance"
  Then I should be on the view episode page for that episode
  
Scenario: Episode details - no enclosure
  Given an episode
  When I hit the view episode page for that episode
  Then I should see the title for that episode
   And I should see the published date for that episode
   And I should see the formatted description for that episode

Scenario: Episode details - enclosure
  Given an episode
    And an enclosure from "tagged.mp3"
  When I hit the view episode page for that episode
  Then I should see the title for that episode
   And I should see the published date for that episode
   And I should see the formatted description for that episode
   And I should see a download link for that episode
   And I should see a duration for that episode
   And I should see a size for that episode


  
