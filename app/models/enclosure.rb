class Enclosure < ActiveRecord::Base
  belongs_to :episode
  
  validates_presence_of :episode
  validates_presence_of :filename
  validates_format_of :filename, :with => /^.+\.[\w\d]+$/
  
  validates_numericality_of :size, :duration, :only_integer => true, :greater_than => 0
  
  
  # Duration parsing stuff -- lots of it
  def duration_hours
    (self.duration || 0) / 3600
  end
  
  def duration_hours=(hours)
    self.duration = ((hours.to_i || 0) * 3600) + (self.duration_minutes * 60) + self.duration_seconds
  end
  
  def duration_minutes
    ((self.duration || 0) % 3600) / 60
  end
  
  def duration_minutes=(minutes)
    self.duration = (self.duration_hours * 3600) + ((minutes.to_i || 0) * 60) + self.duration_seconds
  end
  
  def duration_seconds
    (self.duration || 0) % 60
  end
  
  def duration_seconds=(seconds)
    self.duration = (self.duration_hours * 3600) + (self.duration_minutes * 60) + (seconds.to_i || 0) 
  end
  
  def duration_human
    dh = ''
    dh += "#{duration_hours}hr " if duration_hours > 0
    dh += "#{duration_minutes}min " if duration_minutes > 0
    dh += "#{duration_seconds}sec" if duration_seconds > 0
    dh.strip
  end
  
  def duration_human=(text)
    self.duration_hours = $1 if text =~ /(\d+)\s?hr/
    self.duration_minutes = $1 if text =~ /(\d+)\s?min/
    self.duration_seconds = $1 if text =~ /(\d+)\s?sec/
  end
end
