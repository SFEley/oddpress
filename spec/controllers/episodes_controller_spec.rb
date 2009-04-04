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
          Episode.make(:published_at => 1.day.ago, :title => "This Is The Past")
          Episode.make(:title => "This Is The Present")
          Episode.make(:published_at => 1.day.from_now, :title => "This Is The Future")
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
  
  describe "create action" do
    before(:each) do
      @params = { :episode => { :title => "Test Blah", :publish => "Now" }}
    end
    describe "with an enclosure" do
      before(:each) do
        @params.merge!(:has_enclosure => '1')
        post 'create', @params
        @episode = Episode.find_by_title("Test Blah")
      end
      
      it "redirects to the new enclosure screen" do
        response.should redirect_to(new_episode_enclosure_url(@episode))
      end
      
      it "sets the status to needs_enclosure" do
        @episode.status.should == "needs_enclosure"
      end
    end
    
    describe "with an enclosure" do
      before(:each) do
        post 'create', @params
        @episode = Episode.find_by_title("Test Blah")
      end
      
      it "redirects to the episodes list" do
        response.should redirect_to(episodes_url)
      end
      
      it "sets the status to needs_enclosure" do
        @episode.status.should == "live"
      end
      
    end
  end

end
