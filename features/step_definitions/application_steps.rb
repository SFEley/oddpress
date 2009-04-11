When /^I hit (.*page)$/ do |page|
  visit path_to(page)
end

When /^I hit (.*page) for that (.*)$/ do |page, element|
  visit path_to(page, instance_variable_get("@#{element}"))
end
  
Then /^I should see a (\w+)$/ do |element|
  response.body.should have_tag(element)
end

Then /^I should be on (.*page)$/ do |page|
  current_url.should == path_to(page)
end

Then /^I should be on (.*page) for that (.*)$/ do |page, element|
  current_url.should == path_to(page, instance_variable_get("@#{element}"))
end