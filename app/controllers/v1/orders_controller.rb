class V1::OrdersController < ApplicationController
  before_action :find_notary, only: [:create]
  before_action :find_notary_service, only: [:create]


  def create
      case params[:order_type].downcase
      when "fidusia"
        if "fidusia" == @notary_service.service_type
          order = Order.fidusia_order(current_user, opts, fidusia_params, collateral_params)
          json_response({message: "order created!", order: order}, :created)
        else
          json_response({message: "Invalid service", order: {}}, :ok)
        end
        # relate with fidusia
      when "skmht"
        if "skmht" == @notary_service.service_type
          order = Order.skmht_order(current_user, opts, skmht_params, collateral_params)
          json_response({message: "order created!", order: order}, :created)
        else
          json_response({message: "Invalid service", order: {}}, :ok)
        end
        # related with skhmt
      when "apht"
        if "apht" == @notary_service.service_type
          order = Order.apht_order(current_user, opts, apht_params, collateral_params)
          json_response({message: "order created!", order: order}, :created)
        else
          json_response({message: "Invalid service", order: {}}, :ok)
        end
        # related with apht
      else
        json_response({message: "invalid order_type", order: {}}, :not_found)
      end
  end

  private

    def opts
      {
        order_type: params[:order_type],
        notary_id: @notary.id,
        notary_service_price: @notary_service.id
      }
    end

  	def find_notary
  		@notary = User.find(params[:notary_id])
  	end

  	def find_notary_service
  		@notary_service = @notary.notary_services.find(params[:notary_service_id])
  	end

	def order_params
		params.require(:order).permit(
			:order_type,
			:notary_id,
			:notary_service_id
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
      :collaterals
      )
  end

end
