class EpisodesController < ApplicationController

  
  def index
    @episodes = Episode.current
    if @episodes.empty?
      flash[:warning] = "Sorry, there are no current episodes for this podcast." 
    end
  end
  
end
