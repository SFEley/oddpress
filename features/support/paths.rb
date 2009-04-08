module NavigationHelpers
  def path_to(page_name, parent_object = nil)
    case page_name
    
    when /the homepage/
      root_path
    when /the view episodes page/i
      episodes_url
    when /the create episode page/i
      new_episode_url
    when /the create enclosure page/i
      new_episode_enclosure_url(parent_object)
    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World do |world|
  world.extend NavigationHelpers
  world
end
