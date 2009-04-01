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
      
end
