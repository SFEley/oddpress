require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Episode do
  subject do
    Episode.make_unsaved
  end
  
  it {should be_valid}
  
end
