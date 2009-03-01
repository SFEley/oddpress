# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def styled_flash
    unless flash.empty?
      tags = ""
      flash.each do |type, message|
        tags << content_tag(:div, message, :class => type.to_s)
      end
      content_tag :div, tags, :id => "flash"
    end
  end
      
end
