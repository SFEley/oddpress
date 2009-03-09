require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Episode do
  describe "model" do
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
  
  describe "scoping" do
    at_time "February 27, 2008 3:15 PM EST" do
      before(:each) do
        Episode.make(:posted_at => 1.month.ago, :title => "This Is The Distant Past")
        Episode.make(:posted_at => 1.day.ago, :title => "This Is The Near Past")
        Episode.make(:title => "This Is The Present")
        Episode.make(:posted_at => 1.day.from_now, :title => "This Is The Near Future")
        Episode.make(:posted_at => 1.month.from_now, :title => "This Is The Distant Future")
      end
      
      describe "default order" do
        before(:each) do
          @episodes = Episode.find(:all)
        end
        
        it "has all the episodes" do
          @episodes.should have(5).items
        end
        
        it "has the newest one first" do
          @episodes.first.title.should == "This Is The Distant Future"
        end
        
        it "has the oldest one last" do
          @episodes.last.title.should == "This Is The Distant Past"
        end
      end
      
      describe "current episodes" do
        before(:each) do
          @episodes = Episode.current
        end  
        
        it "omits the future episodes" do
          @episodes.should have(3).items
        end
        
        it "has the present one first" do
          @episodes.first.title.should == "This Is The Present"
        end
        
        it "has the oldest one last" do
          @episodes.last.title.should == "This Is The Distant Past"
        end
        
      end
    end
  end
end
