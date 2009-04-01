require 'faker'
require 'machinist'

# Episodes
Sham.episode_title { Faker::Company.catch_phrase }
Sham.episode_description { Faker::Lorem.paragraphs(2) }
 
Episode.blueprint do
  title { Sham.episode_title }
  published_at { Time.now }
  description { Sham.episode_description }
end

# Enclosures
Sham.enclosure_filename { |i| "file_#{i}.mp3"}

Enclosure.blueprint do
  episode
  filename { Sham.enclosure_filename }
  duration { rand(2.hours) } 
  size { rand(300.megabytes) } 
end

