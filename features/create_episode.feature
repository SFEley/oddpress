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
   | Test Podcast 1| next week| Test duplicate title    | must be unique.           |



  Scenario Outline: Enclosures
    Given I am a contributor
    When I go to the create episode page
     And I fill in "Title" with "Standard title"
     And I fill in "Filename" with "<file>"
     And I fill in "Size" with "<size>"
     And I fill in "Duration" with "<duration>"
     And I press "Save changes"
    Then I should see "<result>"
    
  Examples:
    |filename|size|duration|result|
    |my_test.mp3|1001221|3:30|my_test.mp3|
    ||||did not include an enclosure|
    ||1101|3:30|did not include an enclosure|
    |||3:30|did not include an enclosure|
    ||1101||did not include an enclosure|
    |my_test.mp3||3:30|Size is required if an enclosure is given.|
    |my_test.mp3|1101||Duration is required if an enclosure is given.|
    |my_test.mp3|blah|3:30|Size is not a number|
    |my_test.mp3|1.5|3:30|Size is invalid|
    |my_test.mp3|-5|3:30|Size must be greater than 0|
    |my_test.mp3|0|3:30|Size must be greater than 0|
    |my_test.mp3|1|3:30|my_test.mp3|
    |my_test.mp3|1101|blah|Duration is invalid|
    |my_test.mp3|1101|5:|Duration is invalid|
    |my_test.mp3|1101|:01|my_test.mp3|
    |my_test.mp3|1101|5:000|Duration is invalid|
    |my_test.mp3|1101|5|Duration is invalid|
    |my_test.mp3|1101|5:a|Duration is invalid|
    |my_test.mp3|1101|5:1|Duration is invalid|
    
    
    

  