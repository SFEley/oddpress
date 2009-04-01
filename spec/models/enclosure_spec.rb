require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Enclosure do
  before(:each) do
    @valid_attributes = {
      :episode_id => 1,
      :filename => "value for filename",
      :size => 1,
      :duration => "value for duration"
    }
  end

  it "should create a new instance given valid attributes" do
    Enclosure.create!(@valid_attributes)
  end
end
