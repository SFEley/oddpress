class Episode < ActiveRecord::Base

  validates_uniqueness_of :title
  validates_presence_of :title
  validates_presence_of :published_at, :message => "must be readable as a date."
  
  default_scope :order => "published_at DESC"
  named_scope :current, lambda{{:conditions => ["published_at <= ?", Time.zone.now]}}
  
  # Pagination limit
  cattr_accessor :per_page
  @@per_page = 20
  
  # 'Converter' virtual attribute to easily move strings in and out of published_at
  def publish=(time)
    self.published_at = Chronic.parse(time)
  end
  
  def publish
    self.published_at.try(:to_s, :verbose) || 'Now'
  end
      
  if ENV["RAILS_ENV"] == "test"
    Sham.episode_title { Faker::Company.catch_phrase }
    Sham.episode_description { Faker::Lorem.paragraphs(2) }
    
    self.blueprint do
      title { Sham.episode_title }
      published_at { Time.now }
      description { Sham.episode_description }
    end
  end
end
