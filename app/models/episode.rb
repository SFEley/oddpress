class Episode < ActiveRecord::Base

  validates_uniqueness_of :title
  
  default_scope :order => "published_at DESC"
  named_scope :current, lambda{{:conditions => ["published_at <= ?", Time.zone.now]}}
  
  # Pagination limit
  cattr_accessor :per_page
  @@per_page = 20
  
  def after_initialize
    self.published_at ||= Time.now
  end
    
  if ENV["RAILS_ENV"] == "test"
    Sham.episode_title { Faker::Company.catch_phrase }
    Sham.episode_description { Faker::Lorem.paragraphs(2) }
    
    self.blueprint do
      title { Sham.episode_title }
      description { Sham.episode_description }
    end
  end
end
