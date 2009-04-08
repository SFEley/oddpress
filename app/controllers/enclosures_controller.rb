class EnclosuresController < ApplicationController
  def new
    @episode ||= Episode.find(params[:episode_id])
    @enclosure = @episode.build_enclosure
  end
  
end