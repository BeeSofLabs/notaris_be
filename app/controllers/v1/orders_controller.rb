class V1::OrdersController < ApplicationController
  def create
  	json_response({message: "order created!"})
  end
end
