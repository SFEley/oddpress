class Episode < ActiveRecord::Base
  include AASM
  aasm_column :status
  aasm_initial_state :draft
  
  aasm_state :draft
  aasm_state :needs_enclosure
  aasm_state :processing_enclosure
  aasm_state :needs_review
  aasm_state :live
  
  aasm_event :wait_for_enclosure do
    transitions :to => :needs_enclosure, :from => [:draft, :needs_review, :live]
  end
  
  aasm_event :process_enclosure do
    transitions :to => :processing_enclosure, :from => [:needs_enclosure]
  end
  
  aasm_event :wait_for_review do
    transitions :to => :needs_review, :from => [:draft, :processing_enclosure]
  end
  
  aasm_event :approve do
    transitions :to => :live, :from => [:draft, :processing_enclosure, :needs_review]
  end
  
  has_one :enclosure
  accepts_nested_attributes_for :enclosure, :reject_if => proc {|a| a['filename'].empty?}
  
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
