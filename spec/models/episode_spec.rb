require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Episode do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :description => "value for description",
      :posted_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Episode.create!(@valid_attributes)
  end
end
