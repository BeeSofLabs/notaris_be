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
            order = Order.find params[:order_id]
            if order.present? && order.html_content.present?
                filename = "#{order.document_type}#{order.id}-#{Time.now.strftime('%Y%m%d')}"
                save_path = Rails.root.join('public/pdfs', "#{filename}")
                pdf_path = Html2Pdf.generate(order.html_content, save_path)

                return json_response(  {message: "Document generated in pdf format!", path: "#{save_path}.pdf"}, :ok)
        
            end
        rescue Exception
        end

        json_response(  {message: "Invalid document not generated!"}, :failed)
    end

end