class EpisodesController < ApplicationController
    
  def index
    @episodes = Episode.current.paginate :page => params[:page]
    if @episodes.empty?
      flash[:warning] = "Sorry, there are no current episodes for this podcast." 
    end
  end
  
  def new
    @episode = Episode.new
  end
  
  def create
    @episode = Episode.new(params[:episode])
    if @episode.save
      flash[:notice] = "Episode created."
      if params[:has_enclosure]
        @episode.wait_for_enclosure!
        redirect_to new_episode_enclosure_url(@episode)
      else
        @episode.approve!
        redirect_to :episodes
      end
    else
      render :new
    end
  end
end
