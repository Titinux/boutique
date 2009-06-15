require 'test_helper'
include Admin::OrdersHelper

class OrdersControllerTest < ActionController::TestCase
  test "unauthenticated user shouldn't view orders" do
    get :show, { :id => orders(:three).id }
    
    unautenticated_forbidden
  end
  
  test "authenticated user shouldn't view orders from other users" do
    autenticate('Pim', 'pim')
    
    get :show, { :id => orders(:four) }
    
    assert flash[:error].include?('Access forbidden !')
    assert_redirected_to user_path
  end
  
  test "authenticated user should view his own orders" do
    autenticate('Pim', 'pim')
    
    get :show, { :id => orders(:three).id }
    
    assert_response :success
  end
  
  test "unauthenticated user shouldn't edit order state" do
    orderActionHash.keys.each do |key|
      put :update, { :id => orders(:three), :op => key}
      
      assert_redirected_to login_path
      assert Order.find(orders(:three).id).state == orders(:three).state
    end
  end  
  
  test "authenticated user shouldn't edit state of orders from other users" do
    autenticate('Pam', 'pam')
    
    orderActionHash.keys.each do |key|
      put :update, { :id => orders(:three), :op => key}
      
      assert_redirected_to user_path
      assert Order.find(orders(:three).id).state == orders(:three).state
    end
  end
  
  test "authenticated user should accept estimates on his orders" do
    autenticate('Pim', 'pim')
    
    put :update, { :id => orders(:three), :op => 'ACCEPT_ESTIMATE' }
    
    assert_redirected_to user_path
    assert Order.find(orders(:three).id).state == 'IN_PREPARATION'
  end
  
  test "authenticated user should refuse estimates on his orders" do
    autenticate('Pim', 'pim')
    
    put :update, { :id => orders(:three), :op => 'REFUSE_ESTIMATE' }
    
    assert_redirected_to user_path
    assert Order.find(orders(:three).id).state == 'ORDER_CANCELED'
  end
  
  test "authenticated user shouldn't not modify state of his orders to an unhautorized value" do
    autenticate('Pim', 'pim')
    
    (orderActionHash.keys - %w(ACCEPT_ESTIMATE REFUSE_ESTIMATE)).each do |key|
      put :update, { :id => orders(:three), :op => key}
      
      assert_redirected_to user_path
      assert Order.find(orders(:three).id).state == orders(:three).state
    end
  end
end
