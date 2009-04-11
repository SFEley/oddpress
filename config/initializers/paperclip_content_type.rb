require 'paperclip'
require 'mime/types'

module Paperclip
  module Upfile
    
    # Replace the content_type method in Paperclip with one that really works
    def content_type
      extension = (self.path.match(/\.(\w+)$/)[1] rescue "octet-stream").downcase
      if types = MIME::Types.type_for(extension)  # This returns an array of possible content types
        types.first.to_s  # Most likely result
      else
        "application/x-#{extension}"
      end
    end
  end
end