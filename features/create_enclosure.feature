# Feature: Create Enclosure
#   As a podcaster
#   I want to add an enclosure to an episode
#   So that people have something to listen to
#   
#   
#   Scenario Outline: Enclosures
#     Given I am a contributor
#      And an episode
#     When I go to the create enclosure page
#      And I fill in "Title" with "Standard title"
#      And I fill in "Filename" with "<file>"
#      And I fill in "Size" with "<size>"
#      And I fill in "Duration" with "<duration>"
#      And I press "Save changes"
#     Then I should see "<result>"
#     
#   Examples:
#     |filename|size|duration|result|
#     |my_test.mp3|1001221|3:30|my_test.mp3|
#     ||||did not include an enclosure|
#     ||1101|3:30|did not include an enclosure|
#     |||3:30|did not include an enclosure|
#     ||1101||did not include an enclosure|
#     |my_test.mp3||3:30|Size is required if an enclosure is given.|
#     |my_test.mp3|1101||Duration is required if an enclosure is given.|
#     |my_test.mp3|blah|3:30|Size is not a number|
#     |my_test.mp3|1.5|3:30|Size is invalid|
#     |my_test.mp3|-5|3:30|Size must be greater than 0|
#     |my_test.mp3|0|3:30|Size must be greater than 0|
#     |my_test.mp3|1|3:30|my_test.mp3|
#     |my_test.mp3|1101|blah|Duration is invalid|
#     |my_test.mp3|1101|5:|Duration is invalid|
#     |my_test.mp3|1101|:01|my_test.mp3|
#     |my_test.mp3|1101|5:000|Duration is invalid|
#     |my_test.mp3|1101|5|Duration is invalid|
#     |my_test.mp3|1101|5:a|Duration is invalid|
#     |my_test.mp3|1101|5:1|Duration is invalid|
#     
#     
#     
# 
#   
