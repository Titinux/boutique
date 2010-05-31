require 'test_helper'

class Admin::OrdersControllerTest < ActionController::TestCase
  test "simple user shouldn't get index" do
    autenticate_as_simple_user

    get :index

    admin_section_forbidden
  end

  test "admin should get index" do
    autenticate_as_admin

    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "simple user shouldn't get new" do
    autenticate_as_simple_user

    get :new

    admin_section_forbidden
  end

  test "admin should get new" do
    autenticate_as_admin

    get :new
    assert_response :success
  end

  test "simple user shouldn't create order" do
    autenticate_as_simple_user

    assert_no_difference('Order.count') do
      post :create, :order => { :user => User.first, :state => 1}
    end

    admin_section_forbidden
  end

  test "admin should create order" do
    autenticate_as_admin

    assert_difference('Order.count') do
      post :create, :order => { :user => User.first, :state => 1}
    end

    assert_redirected_to admin_order_path(assigns(:order))
  end

  test "simple user shouldn't show order" do
    autenticate_as_simple_user

    get :show, :id => orders(:one).to_param

    admin_section_forbidden
  end

  test "should show order" do
    autenticate_as_admin

    get :show, :id => orders(:one).to_param
    assert_response :success
  end

  test "simple user shouldn't get edit" do
    autenticate_as_simple_user

    get :edit, :id => orders(:one).to_param

    admin_section_forbidden
  end

  test "admin should get edit" do
    autenticate_as_admin

    get :edit, :id => orders(:one).to_param
    assert_response :success
  end

  test "simple user shouldn't update order" do
    autenticate_as_simple_user

    put :update, :id => orders(:one).to_param, :order => { :user => User.last, :state => 'WAITING_ESTIMATE' }

    admin_section_forbidden
  end

  test "admin should update order" do
    autenticate_as_admin

    put :update, :id => orders(:one).to_param, :order => { :user => User.last, :state => 'WAITING_ESTIMATE' }
    assert_redirected_to admin_order_path(assigns(:order))
  end

  test "simple user shouldn't destroy order" do
    autenticate_as_simple_user

    assert_no_difference('Order.count') do
      delete :destroy, :id => orders(:one).to_param
    end
  end

  test "should destroy order" do
    autenticate_as_admin

    assert_difference('Order.count', -1) do
      delete :destroy, :id => orders(:one).to_param
    end

    assert_redirected_to admin_orders_path
  end
end
