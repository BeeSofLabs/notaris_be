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
        amount          = params[:amount]
        note            = params[:note]

        unless phone.present? && bank_code.present? && bank_account.present?
            return json_response({message: "invalid bank transfer"}, :not_found)
        else
            data = CekMutasiModule::bank_inquiry(phone, bank_code, bank_account)

            if data.present?
                uuid    = data[:response][:uuid]
                token   = data[:response][:token]
                data = CekMutasiModule::bank_transfer(uuid, token, amount, note)
            else
                return json_response({message: "invalid bank transfer"}, :not_found)
            end
        end

        json_response(  {message: "Bank transfered", data: data}, :ok)
    end

    def ovo_transfer
        phone               = params[:phone]
        destination_phone   = params[:destination_phone]
        amount              = params[:amount]

        unless phone.present? && destination_phone.present?
            return json_response({message: "invalid ovo transfer"}, :not_found)
        else
            data = CekMutasiModule::ovo_inquiry(phone, destination_phone)

            if data.present?
                data = CekMutasiModule::ovo_transfer(phone, destination_phone, amount)
            else
                return json_response({message: "invalid ovo transfer"}, :not_found)
            end
        end

        json_response(  {message: "OVO transfer completed", data: data}, :ok)
    end
end