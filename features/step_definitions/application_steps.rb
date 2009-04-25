When /^I hit (.*page)$/ do |page|
  visit path_to(page)
end

When /^I hit (.*page) for that (.*)$/ do |page, model|
  visit path_to(page, instance_variable_get("@#{model}"))
end
  
When /^I click "(.*)"$/ do |page|  # Because Webrat's "I follow" isn't intuitive for me
  When %[I follow "#{page}"]
end

Then /^I should see a (\w+)$/ do |element|
  response.body.should have_tag(element)
end
# 
# Then /^I should be on (.*page) for that (.*)$/ do |page, model|
#   current_url.should == path_to(page, instance_variable_get("@#{model}"))
# end

Then /^I should see (.*) for that (.*)$/ do |element, model|
  attribute = attribute_from(element)
  content = content_for(element, instance_variable_get("@#{model}"))
  response.body.should have_tag("\.#{attribute}", :content => content)
end