require 'rdiscount'

module ElementHelpers
  def attribute_from(element)
    element.gsub! /(the|a) /, ''
    element.gsub! /formatted /, ''
    element.gsub! /\sdate/, ' at'
    element.tr(' ', '_')
  end
  
  def content_for(element, model)
    attribute = attribute_from(element)
    value = model.send(attribute)
    case element
    when /formatted /
      Rdiscount.new(value).to_html
    when /\sdate/
      value.to_s(:verbose)
    else
      value
    end
  end
end

World(ElementHelpers)
