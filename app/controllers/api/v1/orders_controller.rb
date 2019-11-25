class Api::V1::OrdersController < ApplicationController
  before_action :find_notary, only: [:create]
  # before_action :find_notary_service, only: [:  create]

  DOCTYPE_SKMHT = "skmht"
  DOCTYPE_APHT = "apht"
  DOCTYPE_FIDUSIA = "fidusia"


  # def create_order
  #     case params[:document_type].downcase
  #     when "fidusia"
  #       if "fidusia" == @notary_service.service_type
  #         order = Order.fidusia_order(current_user, opts, fidusia_params, collateral_params)
  #         json_response({message: "order created!", order: order}, :created)
  #       else
  #         json_response({message: "Invalid service", order: {}}, :ok)
  #       end
  #       # relate with fidusia
  #     when "skmht"
  #       if "skmht" == @notary_service.service_type
  #         order = Order.skmht_order(current_user, opts, skmht_params, collateral_params)
  #         json_response({message: "order created!", order: order}, :created)
  #       else
  #         json_response({message: "Invalid service", order: {}}, :ok)
  #       end
  #       # related with skhmt
  #     when "apht"
  #       if "apht" == @notary_service.service_type
  #         order = Order.apht_order(current_user, opts, apht_params, collateral_params)
  #         json_response({message: "order created!", order: order}, :created)
  #       else
  #         json_response({message: "Invalid service", order: {}}, :ok)
  #       end
  #       # related with apht
  #     else
  #       json_response({message: "invalid document_type", order: {}}, :not_found)
  #     end
  # end

  def create
    if [DOCTYPE_SKMHT, DOCTYPE_APHT, DOCTYPE_FIDUSIA].include?(order_params[:document_type])
      # if order_params[:document_type].eql?(@notary_service.service_type)

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

    def opts
      {
        document_type: params[:order][:header][:document_type],
        notary_id: @notary.id,
        notary_service_price: @notary_service.id
      }
    end

  	def find_notary
  		@notary = User.find(order_params[:notary_id])
  	end

  	def find_notary_service
  		@notary_service = @notary.notary_services.find(order_params[:notary_service_id])
  	end

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
      :creditor_id,
      :movable_collateral_ids,
      :immovable_collateral_ids
      
      # movable_collaterals: [
      #   :id,
      #   :binding_value,
      #   :brand,
      #   :chassis_number,
      #   :classification,
      #   :collateral_value,
      #   :color,
      #   :imageable_type,
      #   :machine_number,
      #   :movable_asset,
      #   :name_representative,
      #   :no_evidence,
      #   :owner,
      #   :proof_of_ownership,
      #   :publication_date,
      #   :seri,
      #   :brand,
      #   :movable_asset
      # ],
      # immovable_collaterals: [
      #   :id,
      #   :binding_value,
      #   :certificate_number,
      #   :city,
      #   :collateral_value,
      #   :district,
      #   :gs_su_date,
      #   :land_area,
      #   :letter_of_measurement,
      #   :letter_of_pbbtax,
      #   :name_representative,
      #   :no_land_identity,
      #   :nop,
      #   :owner,
      #   :proof_of_ownership,
      #   :province,
      #   :publication_date,
      #   :signed,
      #   :street,
      #   :village
      # ]
		)
	end

  def fidusia_params
    params.permit(
      :binding_value,
      :brand,
      :chassis_number,
      :collateral_value,
      :machine_number,
      :number_of_evidence,
      :on_behalf_of,
      :owner,
      :proof_of_ownership,
      :publication_date,
      :seri,
      :tipe,
      :order_id
    )
  end

  def skmht_params
    params.permit(
      :binding_value,
      :building_land_tax,
      :certificate_number,
      :city,
      :collateral_value,
      :district,
      :land_area_identification_number,
      :letter_of_measurement,
      :nop,
      :on_behalf_of,
      :owner,
      :proof_of_ownership,
      :province,
      :publication_date,
      :street,
      :surface_area,
      :tanggal_gs_su,
      :village
    )
  end

  def apht_params
    params.permit(
      :binding_value,
      :building_land_tax,
      :certificate_number,
      :city,
      :collateral_value,
      :district,
      :land_area_identification_number,
      :letter_of_measurement,
      :nop,
      :on_behalf_of,
      :owner,
      :proof_of_ownership,
      :province,
      :publication_date,
      :street,
      :surface_area,
      :tanggal_gs_su,
      :village
    )
  end

  def collateral_params
    params.permit(
      :collaterals => []
      )
  end

end
