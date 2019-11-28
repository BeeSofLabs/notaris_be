class Api::V1::DocumentsController < ApplicationController

    def show
        temp_path = "public/document/"
        case(params[:doctype])
        when 'skmht'
            temp_path += "skmht_template.html"
        when 'apht'
            temp_path += "apht_template.html"
        when 'covernote'
            temp_path += "covernote_template.html"
        when 'fidusia'
            temp_path += "fidusia_template.html"
        else
            return json_response({message: "invalid document type"}, :not_found)
        end

        data = File.read(temp_path).gsub("\n", '').strip!
        json_response(  {tipe: params[:doctype], template: data}, :ok)

    end

end