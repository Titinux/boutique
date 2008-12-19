require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should show order" do
    get :show, :id => orders(:one).id
    assert_response :success
  end
end
