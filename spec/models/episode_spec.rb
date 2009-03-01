require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Episode do
  before do
    @this = Episode.make_unsaved
  end
  
  it "is valid" do
     @this.should be_valid
  end
  
  it "can save" do
    @this.save.should be_true
  end
  
  it "has a unique title" do
    @that = Episode.make(:title => "blah")
    @this.title = "blah"
    @this.should_not be_valid
  end
  
  it "defaults the posted_at date to the current time" do
    at_time Time.now do |time|
      @that = Episode.make
      @that.posted_at.to_s(:long).should == time.to_s(:long)
    end
  end
  
  it "allows override of posted_at date" do
    @that = Episode.make(:posted_at => "January 3, 2009 2:21 PM")
    @that.posted_at.to_s(:long).should == Time.parse("January 3, 2009 2:21 PM UTC").to_s(:long)
  end
end
