module NavigationHelpers
  def path_to(page_name, parent_object = nil)
    case page_name
    when /(the .+ page) for that (.*)/
      return path_to($1, instance_variable_get("@#{$2}"))
    when /the home\s?page/i  # The linguistics of the "homepage" compound word annoy me
      root_path
    when /the view episodes page/i
      episodes_path
    when /the create episode page/i
      new_episode_path
    when /the create enclosure page/i
      new_episode_enclosure_path(parent_object)
    when /the view episode page/i
      episode_path(parent_object)
    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)
