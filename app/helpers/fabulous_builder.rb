class FabulousBuilder < ActionView::Helpers::FormBuilder
  def line
    @template.content_tag("div", yield, :class => "line")
  end

  #TODO: select and collection_select
  
  # def select(method, choices, options = {}, html_options = {})
  #   label_text = options[:label] || method.to_s.titleize
  #   output = label(method, label_text, options) + "\n<br/>\n" + 
  #             @template.send("select", @object_name, method, choices, 
  #               objectify_options(options), objectify_options(html_options))
  #   @template.content_tag("div", output, :class => "field select")
  # end

  
  protected
    
    TITLE_ON_TOP = %q{ label(method, label_text, options) + "\n<br/>\n" + super }
    TITLE_AFTER = %q{ super + label(method, label_text, options) }

    def self.create_field(field_name, labeler)
      class_eval <<-ENDMETHOD
        def #{field_name} (method, options = {})
          label_text = options[:label] || method.to_s.titleize
          output = #{labeler}
          @template.content_tag("div", output, :class => "field #{field_name}")
        end
      ENDMETHOD
    end
  
    %w{ text_field 
        password_field 
        file_field 
        text_area }.each do |field_name|
      create_field(field_name, TITLE_ON_TOP)
    end
    
    %w{ check_box
        radio_button }.each do |field_name|
      create_field(field_name, TITLE_AFTER)
    end
  
end
