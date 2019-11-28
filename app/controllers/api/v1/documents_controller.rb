class Api::V1::DocumentsController < ApplicationController

    def show
        content = ::Document.content_template(params[:doctype])

        unless content
            return json_response({message: "invalid document type"}, :not_found)
        else
            json_response(  {tipe: params[:doctype], template: content}, :ok)
        end

    end

end