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
    it "is required" do
      @this.duration = nil
      @this.should_not be_valid
    end
  end
  
    it "requires a duration" do
      @this.duration = nil
      @this.should_not be_valid
    end
    
    it "size "
  end
end
