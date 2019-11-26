class Api::V1::OrdersController < ApplicationController
  before_action :find_notary, only: [:create]

  DOCTYPE_SKMHT = "skmht"
  DOCTYPE_APHT = "apht"
  DOCTYPE_FIDUSIA = "fidusia"

  def create
    if [DOCTYPE_SKMHT, DOCTYPE_APHT, DOCTYPE_FIDUSIA].include?(order_params[:document_type])

        if order_params[:document_type] != DOCTYPE_FIDUSIA
          order = Order.create_order_with_immovable_collateral(current_user, order_params, params[:immovable_collateral_ids])
        else
          order = Order.create_order_with_movable_collateral(current_user, order_params, params[:movable_collateral_ids])
        end

        #  checking order valid or not
        if order.present? 
          json_response({message: "order created!", order: order}, :created)
        else
          json_response({message: "Invalid service", order: {}}, :unprocessable_entity)
        end
    else
        json_response({message: "invalid document type", order: {}}, :not_found)
    end
  end

  private
  
	def order_params
		params.permit(
      :agunan_pokok,
      :angsuran_bunga,
      :total_price,
      :jangka_waktu,
      :no_perjanjian,
      :plafond,
      :tgl_akad,
      :tgl_jatuh_tempo,
      :valid_expired_datetime,
      :document_type,
      :no_request_order,
      :notary_id,
      :user_id,
      :collateral_owner_id,
      :debtor_id,
      :creditor_id
		)
	end

end
