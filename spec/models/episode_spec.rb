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

  it "defaults the published_at date to the current time" do
    at_time Time.now do |time|
      @that = Episode.make
      @that.published_at.to_s(:long).should == time.to_s(:long)
    end
  end

  it "allows override of published_at date" do
    @that = Episode.make(:published_at => "January 3, 2009 2:21 PM")
    @that.published_at.to_s(:long).should == Time.parse("January 3, 2009 2:21 PM UTC").to_s(:long)
  end
  
  describe "publish attribute" do
    before(:each) do
      @this.published_at = "July 9, 2011 7:17 PM MDT"
    end
  
    it "sets the published_at date when assigned" do
      @this.publish = 'two days ago'
      @this.published_at.utc.to_s(:verbose).should == 2.days.ago.utc.to_s(:verbose)
    end
  
    it "retrieves the published_at date in plain English" do
      @this.publish.should == "Sunday, July 10, 2011 at 01:17 AM UTC"
    end
  
    it "throws a validation error when an unparseable string is given" do
      @this.publish = 'blah blah yadda'
      @this.should have(1).error_on(:published_at)
    end
  end

  describe "scoping" do
    at_time "February 27, 2008 3:15 PM EST" do
      before(:each) do
        Episode.make(:published_at => 1.month.ago, :title => "This Is The Distant Past")
        Episode.make(:published_at => 1.day.ago, :title => "This Is The Near Past")
        Episode.make(:title => "This Is The Present")
        Episode.make(:published_at => 1.day.from_now, :title => "This Is The Near Future")
        Episode.make(:published_at => 1.month.from_now, :title => "This Is The Distant Future")
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
  
  describe "enclosure attachment" do
    before(:all) do
      # Set up sample enclosure files
      example_dir = Rails.root.join('spec','examples')
      @untagged_file = File.new(example_dir + 'untagged.mp3')
      @document_file = File.new(example_dir + 'document.pdf')
    end

    before(:each) do
      @this.enclosure = @document_file
    end
    
    it "is optional" do
      @this.enclosure = nil
      @this.should be_valid
    end
    
    it "can be assigned a file" do
      @this.should be_valid
    end
    
    it "knows its size" do
      @this.enclosure.size.should == 365677
    end
    
    it "knows its content type" do
      @this.enclosure.content_type.should == 'application/pdf'
    end
    
    it "knows its filename" do
      @this.enclosure.original_filename.should == 'document.pdf'
    end
    
    it "saves when the model is saved" do
      @this.enclosure.should_receive(:save).and_return(true)
      @this.save
    end
  end
  
  # describe "status" do
  #   before(:each) do
  #     @this.save
  #   end
  #   
  #   it "begins as draft" do
  #     @this.status.should == "draft"
  #   end
  #   
  #   it "moves to needs_enclosure if the right box is checked" do
  #     @this.wait_for_enclosure!
  #     @this.status.should == "needs_enclosure"
  #   end
  #   
  #   it "moves to live if no enclosure is needed" do
  #     @this.approve!
  #     @this.status.should == "live"
  #   end
  # end
end
