require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Enclosure do
  before(:each) do
    @episode = Episode.make
    @this = Enclosure.make_unsaved(:episode => @episode)
  end

  it "succeeds" do
    @this.should be_valid
  end
  
  it "saves" do
    @this.save.should be_true
  end
  
  it "has an episode" do
    @this.episode = nil
    @this.should_not be_valid
  end
  

  describe "filename" do
    it "is required" do
      @this.filename = nil
      @this.should_not be_valid
    end
    
    it "has an extension" do
      @this.filename = "noext"
      @this.should_not be_valid
      @this.filename += '.txt'
      @this.should be_valid
    end
  end
  
  describe "size" do
    
    it "is required" do
      @this.size = nil
      @this.should_not be_valid
    end
    
    it "is a number" do
      @this.size = 'blah'
      @this.should_not be_valid
    end
    
    it "isn't negative" do
      @this.size = -1
      @this.should_not be_valid
    end
    
    it "isn't zero" do
      @this.size = 0
      @this.should_not be_valid
    end
    
    it "is an integer" do
      @this.size = 3.5
      @this.should_not be_valid
    end
    
  end
  
  describe "duration" do
    before(:each) do
      @this.duration = nil
    end
    
    it "is required" do
      @this.should_not be_valid
    end
    
    it "it is a number" do
      @this.duration = 'blah'
      @this.should_not be_valid
    end
    
    it "isn't negative" do
      @this.duration = -1
      @this.should_not be_valid
    end
    
    it "isn't zero" do
      @this.duration = 0
      @this.should_not be_valid
    end
    
    it "is an integer" do
      @this.duration = 3.5
      @this.should_not be_valid
    end
    
    describe "(hours)" do
      it "sets the duration" do
        @this.duration_hours = 2
        @this.duration.should == 7200
      end
      
      it "is rounded from duration" do
        @this.duration = 5400
        @this.duration_hours.should == 1
      end
    end

    describe "(minutes)" do
      it "sets the duration" do
        @this.duration_minutes = 3
        @this.duration.should == 180
      end
      
      it "is rounded from duration" do
        @this.duration = 250
        @this.duration_minutes.should == 4
      end
      
      it "ignores hours" do
        @this.duration = 5410
        @this.duration_minutes = 30
      end
    end

    describe "(seconds)" do
      it "sets the duration" do
        @this.duration_seconds = 17
        @this.duration.should == 17
      end
      
      it "is based on duration" do
        @this.duration = 7
        @this.duration_seconds.should == 7
      end
      
      it "ignores minutes" do
        @this.duration = 210
        @this.duration_seconds.should == 30
      end

      it "ignores hours" do
        @this.duration = 5410
        @this.duration_seconds.should == 10
      end
    end
    
    describe "(human)" do
      it "sets the duration" do
        @this.duration_human = "1hr 30min 10sec"
        @this.duration.should == 5410
      end
      
      it "is derived from duration" do
        @this.duration = 7322
        @this.duration_human.should == "2hr 2min 2sec"
      end
    end

  end
  
 
end
