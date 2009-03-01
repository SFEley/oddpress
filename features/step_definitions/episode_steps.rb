Given "no episodes" do
  Episode.destroy_all
end

Given /^an episode titled "(.*)"$/ do |title|
  @episode = Episode.make(:title => title)
end


