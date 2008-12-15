require 'test_helper'

class OrderLinesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_line" do
    assert_difference('OrderLine.count') do
      post :create, :order_line => { }
    end

    assert_redirected_to order_line_path(assigns(:order_line))
  end

  test "should show order_line" do
    get :show, :id => order_lines(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => order_lines(:one).id
    assert_response :success
  end

  test "should update order_line" do
    put :update, :id => order_lines(:one).id, :order_line => { }
    assert_redirected_to order_line_path(assigns(:order_line))
  end

  test "should destroy order_line" do
    assert_difference('OrderLine.count', -1) do
      delete :destroy, :id => order_lines(:one).id
    end

    assert_redirected_to order_lines_path
  end
end
