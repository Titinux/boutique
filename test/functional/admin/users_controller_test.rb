require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :name => 'New user', :guild => Guild.find_by_name('Famakna Food'), :admin => false}
    end

    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "should show user" do
    get :show, :id => users(:Bagu).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => users(:Bagu).id
    assert_response :success
  end

  test "should update user" do
    put :update, :id => users(:Bagu).id, :user => { }
    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:Bagu).id
    end

    assert_redirected_to admin_users_path
  end
end