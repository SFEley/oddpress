Feature: View Episodes
  As a listener
  I want to see a list of episodes
  So that I can experience the joy of consuming them
  
  Scenario: No episodes
    Given no episodes
    When I visit "/"
    Then I should see "no current episodes"
    
  Scenario: One episode
    Given an episode titled "My Test Episode"
    When I visit "/"
    Then I should see "My Test Episode"
     And I should not see "no current episodes" 
     
  