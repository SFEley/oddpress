Feature: Create Episode
  As a podcaster
  I want to post a new episode
  So that people will hear my beautiful voice
  
  Scenario: View Form
   Given I am a contributor
    When I go to the homepage
     And I follow "New episode"
    Then I should see a form
    
  Scenario Outline: Form Entry
    Given I am a contributor
     When I go to the create episode page
      And I fill in "Title" with "<title>"
      And I select "<date>" as the relative date and time
      And I fill in "Description" with "<description>"
     Then I should see "<result>"
    
  Examples:
    | title         | date     | description                                        | result          |
    | Test Podcast 1| tomorrow | This is just a test. Please do not adjust your set.| Episode created.|
    |               | tomorrow | Test with missing title.                           | requires a title|
    | Test Podcast 2|          | Test with missing date.                            | Episode created.|
    | Test Podcast 3| tomorrow |                                                    | Episode created.|
    | Test Podcast 4| yesterday| Test with past date.                               | Episode created.|
