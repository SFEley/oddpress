Then /^I should see a (\w+)$/ do |element|
  response.body.should have_tag(element)
end