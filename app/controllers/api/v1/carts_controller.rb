class Api::V1::CartsController < ApplicationController
  # skip_before_action :authorize_request, only: [:index]

  def index
    carts = current_user.get_carts(params)
    json_response({ carts: carts }, :ok)
  end
end
