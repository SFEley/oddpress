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
  
end
