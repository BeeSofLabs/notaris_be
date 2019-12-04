module Html2Pdf
    def self.generate(htmlText, file_path)
        pdf = WickedPdf.new.pdf_from_string(htmlText)
        
        File.open(file_path, 'wb') do |file|
            file << pdf
        end

    end
end
