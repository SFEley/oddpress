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
      And I fill in "Publish" with "<date>"
      And I fill in "Description" with "<description>"
      And I press "Save changes"
     Then I should see "<result>"
    Examples:
     | title         | date     | description             | result                    |
     | Test Podcast 1| tomorrow | This is just a test.    | Episode created.          |
     |               | tomorrow | Test with missing title.| can't be blank            |
     | Test Podcast 2|          | Test with missing date. | must be readable as a date|
     | Test Podcast 3| tomorrow |                         | Episode created.          |
     | Test Podcast 4| yesterday| Test with past date.    | Episode created.          |
     | Test Podcast 5| blah blah| Test with broken date   | must be readable as a date|
#     | Test Podcast 1| next week| Test duplicate title    | must be unique.           |

 Scenario: Add Enclosure
   Given I am a contributor
    When I go to the create episode page
     And I fill in "Title" with "Any title"
     And I fill in "Publish" with "Now"
     And I upload "untagged.mp3"
     And I press "Save changes"
    Then I should have an episode titled "Any title"
     And the episode should have an enclosure
     And I should be on the view episodes page
