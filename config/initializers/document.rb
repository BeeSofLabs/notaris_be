module Document
    
    def self.content_template(doctype)
        temp_path = "public/document/"

        case doctype
        when 'skmht'
            temp_path += "skmht_template.html"
        when 'apht'
            temp_path += "apht_template.html"
        
        when 'fidusia'
            temp_path += "fidusia_template.html"
        when 'covernote'
            temp_path += "covernote_template.html"
        else
            return nil
        end
        
        File.read(temp_path).encode('ASCII-8BIT', :invalid => :replace, :undef => :replace).gsub("\n", '').strip
    end
end