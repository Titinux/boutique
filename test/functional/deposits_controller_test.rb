require 'test_helper'

class DepositsControllerTest < ActionController::TestCase

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

  test "unautenticate shouldn't create deposits" do
    post :create, :deposit => { :asset_id => assets(:Iron).to_param, :quantity => 25 }
    assert_redirected_to login_path
  end

  test "simple user shouldn't create deposits" do
    autenticate_as_simple_user

    post :create, :deposit => { :asset_id => assets(:Iron).to_param, :quantity => 25 }
    assert_redirected_to root_path
  end

  test "gatherer should create deposits" do
    autenticate_as_gatherer

    assert_difference("user_session.user.deposits.validated(false).count") do
      assert_no_difference("user_session.user.deposits.validated.count") do
        post :create, :deposit => { :asset_id => assets(:Iron).to_param, :quantity_modifier => 25 }
        assert_redirected_to user_deposits_path
      end
    end
  end
end
