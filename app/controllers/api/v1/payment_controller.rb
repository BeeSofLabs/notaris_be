class Api::V1::PaymentController < ApplicationController
    skip_before_action :authorize_request, only: [:bank]

    def bank
        phone = params[:phone]
        unless phone.present?
            return json_response({message: "invalid bank call"}, :not_found)
        else
            bank = CekMutasiModule::bank_list(phone)
        end

        json_response(  {message: "Bank listed", bank: bank}, :ok)
    end

    def bank_transfer
        phone           = params[:phone]
        bank_code       = params[:bank_code]
        bank_account    = params[:bank_account]
        note            = params[:note]
        order_id        = params[:order_id]

        unless phone.present? && bank_code.present? && bank_account.present?
            return json_response({message: "invalid bank transfer"}, :not_found)
        else
            data = CekMutasiModule::bank_inquiry(phone, bank_code, bank_account)

            if data.present?
                order   = Order.find(order_id)
                uuid    = data[:response][:uuid]
                token   = data[:response][:token]
                amount  = order.total_price
                
                data = CekMutasiModule::bank_transfer(uuid, token, amount, note)
                
                order.update(status: :paid)
            else
                return json_response({message: "invalid bank transfer"}, :not_found)
            end
        end

        json_response(  {message: "Bank transfered", data: data}, :ok)
    end

    def ovo_transfer
        phone               = params[:phone]
        destination_phone   = params[:destination_phone]
        order_id            = params[:order_id]

        unless phone.present? && destination_phone.present?
            return json_response({message: "invalid ovo transfer"}, :not_found)
        else
            data = CekMutasiModule::ovo_inquiry(phone, destination_phone)

            if data.present?
                order = Order.find(order_id)
                amount = order.total_price
                data = CekMutasiModule::ovo_transfer(phone, destination_phone, amount)
                
                if order.document_type == Api::V1::OrdersController::DOCTYPE_SKMHT
                    order.update(status: :paid)
                else
                    order.update(status: :partial)
                    if order.document_type == Api::V1::OrdersController::DOCTYPE_APHT
                        return json_response(  {message: "APHT telah selesai dibuat", data: data}, :ok)
                    else order.document_type == Api::V1::OrdersController::DOCTYPE_FIDUSIA
                        return json_response(  {message: "FIDUSIA telah selesai dibuat", data: data}, :ok)
                    end
                    
                end
            else
                return json_response({message: "invalid ovo transfer"}, :not_found)
            end
        end

        json_response(  {message: "SKMHT telah selesai dibuat", data: data}, :ok)
    end
end