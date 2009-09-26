require 'test_helper'

class DepositesControllerTest < ActionController::TestCase
  
  test "unauthenticated should not view" do
    get :index
    assert_redirected_to login_path
  end
  
  test "simple user should not view" do
    autenticate_as_simple_user
    get :index
    assert_redirected_to root_path
  end
  
  test "gatherer should view" do
    autenticate_as_gatherer
    get :index
    assert_response :success
  end
  
  test "unautenticated should not get new" do
    get :new
    assert_redirected_to login_path
  end
  
  test "simple user should not get new" do
    autenticate_as_simple_user
    get :new
    assert_redirected_to root_path
  end
  
  test "gatherer should get new" do
    autenticate_as_gatherer
    get :new
    assert_response :success
  end
  
  test "unautenticate shouldn't create deposites" do
    post :create, :deposite => { :asset_id => assets(:Iron).id, :quantity => 25 }
    assert_redirected_to login_path
  end
  
  test "simple user shouldn't create deposites" do
    autenticate_as_simple_user
    
    post :create, :deposite => { :asset_id => assets(:Iron).id, :quantity => 25 }
    assert_redirected_to root_path
  end
  
  test "gatherer should create deposites" do
    autenticate_as_gatherer
    
    assert_difference("user_session.user.deposites.validated(false).count") do
      assert_no_difference("user_session.user.deposites.validated.count") do
        post :create, :deposite => { :asset_id => assets(:Iron).id, :quantity => 25 }
        assert_redirected_to deposites_path
      end
    end
  end
end