require 'test_helper'

class OrderLinesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_lines)
  end

  test "should show order_line" do
    get :show, :id => order_lines(:one).id
    assert_response :success
  end
end
