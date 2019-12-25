class Api::V1::DocumentsController < ApplicationController

    def approval
        order = Order.find params[:order_id]
        unless order
            return json_response({message: "invalid document"}, :not_found)
        else
            if approval_params[:approve]
                order.update(has_debtor_signed: approval_params[:approve]) if current_user.debtor?
                order.update(has_creditor_signed: approval_params[:approve]) if current_user.creditor?
                order.update(has_pa_signed: approval_params[:approve]) if current_user.collateral_owner?
            end

            if approval_params[:submit]
                order.update(status: :approval)
            end
        end
        json_response(  {message: "Order approval", status: order.status}, :ok)
    end

    def parties
        order = Order.find params[:order_id]
        unless order
            return json_response({message: "invalid document"}, :not_found)
        else

            json_response(  {message: "Document listed", document: OrderPartiesSerializer.new(order)}, :ok)
        end
    end

    def show
        template = ::Document.content_template(params[:doctype])

        unless template
            return json_response({message: "invalid document type"}, :not_found)
        else
            begin
                order = Order.find params[:order_id]
                content = order.html_content
            rescue Exception
                content = ""
            end
            json_response(  {tipe: params[:doctype], template: template, content: content}, :ok)
        end

    end

    def upload
        begin
            order = Order.find params[:order_id]
            if order.present? && params[:html_content].present?
                if order.status == Order::statuses[:partial]

                    if order.update(html_content: params[:html_content], status: :claim)
                      order.delay(run_at: 48.hours.from_now).check_status('claim')
                    end

                    if order.document_type == Api::V1::OrdersController::DOCTYPE_FIDUSIA
                        return json_response(  {message: "Agunan telah selesai dibebankan Hak Tanggungan pada Kanwil Kemenkumham provinsi"}, :ok)
                    else
                        return json_response(  {message: "Agunan telah selesai dibebankan Hak Tanggungan pada BPN Kota"}, :ok)
                    end
                else
                    order.update(html_content: params[:html_content], status: :revision)
                    return json_response(  {message: "Document content updated!"}, :ok)
                end

            end
        rescue Exception
        end

        json_response(  {message: "Invalid document not updated!"}, :failed)
    end

    def generate_pdf
        begin
            privy = nil

            pdf_path = Order.build_file(params[:order_id]).to_s
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


    private
    def approval_params
        params.permit(
            :order_id,
            :approve,
            :submit
        )
    end

end