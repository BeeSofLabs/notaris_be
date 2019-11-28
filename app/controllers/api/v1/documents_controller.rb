class Api::V1::DocumentsController < ApplicationController

    def show
        temp_path = "tmp/document/"
        case(params[:doctype])
        when 'skmht'
            temp_path += "skmht_template.html"
        when 'apht'
            temp_path += "apht_template.html"
        when 'covernote'
            temp_path += "covernote_template.html"
        when 'fidusia'
            temp_path += "fidusia_template. html"
        end

        data = File.read(temp_path).gsub("\n", '')
        json_response(  {tipe: params[:doctype], template: data}, :ok)

    end

end