EXAMPLE_FILES_DIR = Rails.root.join('spec','examples')

Given "no episodes" do
  Episode.destroy_all
end

Given /^(\d+) episode[s]?$/ do |num|
  num.to_i.times do
    Episode.make
  end
end

Given /^an episode$/ do
  @episode = Episode.make
end

Given /^an episode titled "(.*)"$/ do |title|
  @episode = Episode.make(:title => title)
end

Given /^an episode titled "(.*)" dated (.*)$/ do |title, date|
  @episode = Episode.make(:title => title, :published_at => Chronic.parse(date))
end

Given /^an enclosure from "(.*\..*)"$/ do |filename|
  @episode.enclosure = File.new(EXAMPLE_FILES_DIR.join(filename))
end

When /^I upload "(.*\..*)"$/ do |filename|
  When %[I attach the file at "#{EXAMPLE_FILES_DIR.join(filename)}" to "Enclosure"]
end

Then /^I should see (\d+) episodes$/ do |num|
  response.body.should have_tag(".episode", num.to_i)
end

Then /^I should see the episode titled "(.*)"\s?(.*)?$/ do |title, order|
  if order
    response.body.should have_tag(".episode") do |episodes|
      episodes.send(order).should have_tag(".title", title)
    end
  else
    response.body.should have_tag(".episode>.title", title)
  end
end
    
Then /^I should see that episode's title$/ do
  response.body.should include_text(@episode.title)
end

Then /^I should see that episode's published date$/ do  
  response.body.should include_text(@episode.published_at.to_s(:long))
end
  
Then /^I should see that episode's description$/ do
  response.body.gsub(/[^\w]/, '').should include_text(@episode.description.gsub(/[^\w]/, ''))
end

Then /^I should have an episode titled "(.*)"$/ do |title|
  @episode = Episode.find_by_title(title)
  @episode.should_not be_nil
end

Then /^the episode should have an enclosure$/ do
  @episode.enclosure.should be_a_file
end


