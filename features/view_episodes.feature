Feature: View Episodes
  As a listener
  I want to see a list of episodes
  So that I can experience the joy of consuming them
  
  Scenario: No episodes
    Given no episodes
    When I go to the homepage
    Then I should see "no current episodes"
    
  Scenario: One episode
    Given an episode titled "My Test Episode"
    When I go to the homepage
    Then I should see "My Test Episode"
     And I should not see "no current episodes" 
     
  Scenario: Several episodes
    Given 10 episodes
     When I go to the homepage
     Then I should see 10 episodes
    
  Scenario: More episodes than limit of 20
    Given 30 episodes
     When I go to the homepage
     Then I should see 20 episodes
      And I should see "Older"
     
  Scenario: Newest episode first
    Given an episode titled "Oldest" dated January 1 1990
      And an episode titled "Newest" dated March 9 2008
      And an episode titled "Middle" dated September 5 2004
     When I go to the homepage
     Then I should see 3 episodes
      And I should see the episode titled "Newest" first
      And I should see the episode titled "Middle" second
      And I should see the episode titled "Oldest" third
      
  Scenario: Doesn't show future episodes
    Given an episode titled "Oldest" dated two days ago
      And an episode titled "Recent" dated yesterday
      And an episode titled "Future" dated tomorrow
     When I go to the homepage
     Then I should see 2 episodes
      And I should see the episode titled "Oldest" second
      And I should see the episode titled "Recent" first
      
  Scenario: Episode details
    Given an episode
    When I go to the homepage
    Then I should see that episode's title
     And I should see that episode's description
     And I should see that episode's published date
     
