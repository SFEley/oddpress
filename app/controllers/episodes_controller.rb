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
      redirect_to :episodes
    else
      render :new
    end
  end
end
