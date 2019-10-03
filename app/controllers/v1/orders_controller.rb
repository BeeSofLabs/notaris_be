class V1::OrdersController < ApplicationController
  before_action :find_notary, only: [:create]
  before_action :find_notary_service, only: [:create]


  def create
  	order = current_user.orders.create!(
  		order_type: params[:order_type],
  		notary_id: @notary.id,
  		grand_total: @notary_service.price
	)
  	json_response({message: "order created!", order: order}, :created)
  end

  private

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
end
