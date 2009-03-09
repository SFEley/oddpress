Given "no episodes" do
  Episode.destroy_all
end

Given /^an episode titled "(.*)"$/ do |title|
  @episode = Episode.make(:title => title)
end

Given /^(\d+) episodes$/ do |num|
  num.to_i.times do
    Episode.make
  end
end

Then /^I should see (\d+) episodes$/ do |num|
  response.body.should have_tag(".episode", num.to_i)
end

