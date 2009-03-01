class Episode < ActiveRecord::Base

  if ENV["RAILS_ENV"] == "test"
    Sham.episode_title { Faker::Company.catch_phrase }
    Sham.episode_description { Faker::Lorem.paragraphs(2) }
    
    self.blueprint do
      title { Sham.episode_title }
      description { Sham.episode_description }
    end
  end
end
