require 'test_helper'

class V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get v1_orders_create_url
    assert_response :success
  end

end
