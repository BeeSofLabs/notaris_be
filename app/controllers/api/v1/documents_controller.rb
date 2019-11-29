class Api::V1::DocumentsController < ApplicationController

    def show
        content = ::Document.content_template(params[:doctype])

        unless content
            return json_response({message: "invalid document type"}, :not_found)
        else
            json_response(  {tipe: params[:doctype], template: content}, :ok)
        end

    end

    def upload
        begin
            order = Order.find params[:order_id]
            if order.present? && params[:html_content].present?
                order.update(html_content: params[:html_content])
                return json_response(  {message: "Document content updated!"}, :ok)
        
            end
        rescue Exception
        end

        json_response(  {message: "Invalid document not updated!"}, :failed)
    end

    def generate_pdf
        begin
            privy = nil
            
            pdf_path = Order.build(params[:order_id]).to_s
            if params[:with_privy]
                order = Order.find params[:order_id]
                
                privy = PrivyModule::upload_document(
                    order.document_type.camelcase, 
                    order.creditor.privy_id, 
                    "TE4455", 
                    File.new(pdf_path))
                

                if privy[:data].present?
                    order.update(
                        doc_token_privy: privy[:data][:docToken],
                        url_document_privy: privy[:data][:urlDocument])
                end
                
            end
            return json_response( 
                {   message: "Document generated in pdf format!", 
                    path: "#{pdf_path}", 
                    privy: privy }, :ok)
        rescue Exception
        end

        json_response(  {message: "Invalid document not generated!"}, :failed)
    end

end