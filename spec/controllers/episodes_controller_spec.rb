require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EpisodesController do
  integrate_views

  describe "index action" do
    describe "with no episodes" do
      before(:each) do
        Episode.destroy_all
      end
      
      it "returns a 'no current episodes' warning" do
        get 'index'
        response.should include_text("no current episodes")
      end
    end
    
    describe "with past and future episodes" do
      at_time "January 3, 2009 2:25 PM EST" do
        before(:each) do
          Episode.make(:posted_at => 1.day.ago, :title => "This Is The Past")
          Episode.make(:title => "This Is The Present")
          Episode.make(:posted_at => 1.day.from_now, :title => "This Is The Future")
        end
        
        it "shows the past episode" do
          get 'index'
          response.should include_text("This Is The Past")
        end
        
        it "shows the present episode" do
          get 'index'
          response.should include_text("This Is The Present")
        end
        
        it "does not show the future episode" do
          get 'index'
          response.should_not include_text("This Is The Future")
        end
      end
    end
  end

end
