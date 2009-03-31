def path_to(page_name)
  case page_name
  
  when /the homepage/i
    root_path
  when /the create episode page/i
    new_episode_url
  
  # Add more page name => path mappings here
  
  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end