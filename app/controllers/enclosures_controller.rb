class EnclosuresController < ApplicationController
  def new
    @episode ||= Episode.find(params[:episode_id])
    @enclosure = @episode.build_enclosure
  end
  
  def create
    @episode ||= Episode.find(params[:episode_id])
    @enclosure = @episode.create_enclosure(params[:enclosure])
  end
end