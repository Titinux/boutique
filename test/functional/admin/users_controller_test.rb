require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  test "simple user shouldn't get index" do
    autenticate_as_simple_user

    get :index

    admin_section_forbidden
  end

  test "admin should get index" do
    autenticate_as_admin

    get :index
    assert_response :success
    assert_not_nil assigns(:users)
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

  test "simple user shouldn't create user" do
    assert_no_difference('User.count') do
      post :create, :user => { :name => 'Foobar user',
                               :guild_id => guilds(:Famakna_food).to_param,
                               :email => 'foo@bar.com',
                               :admin => false,
                               :gatherer => false
                             }
    end

    admin_section_forbidden
  end


  test "admin should create user" do
    autenticate_as_admin

    assert_difference('User.count') do
      post :create, :user => { :name => 'Foobar user',
                               :password => '1234567',
                               :guild_id => guilds(:Famakna_food).to_param,
                               :email => 'foo@bar.com',
                               :admin => false,
                               :gatherer => false
                             }
    end

    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "simple user should show user" do
    autenticate_as_simple_user

    get :show, :id => users(:Tata).to_param

    admin_section_forbidden
  end

  test "admin should show user" do
    autenticate_as_admin

    get :show, :id => users(:Tata).to_param
    assert_response :success
  end

  test "simple user should get edit" do
    autenticate_as_simple_user

    get :edit, :id => users(:Tata).to_param

    admin_section_forbidden
  end

  test "admin should get edit" do
    autenticate_as_admin

    get :edit, :id => users(:Tata).to_param
    assert_response :success
  end

  test "simple user shouldn't update user" do
    autenticate_as_simple_user

    put :update, :id => users(:Tata).to_param, :user => { :email => 'foo@bar.com' }

    admin_section_forbidden
  end


  test "admin should update user" do
    autenticate_as_admin

    assert_no_difference('User.count') do
      put :update, :id => users(:Tata).to_param, :user => { :email => 'foo@bar.com' }
    end
    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "simple user shouldn't destroy user" do
    autenticate_as_simple_user

    assert_no_difference('User.count') do
      delete :destroy, :id => users(:Tata).to_param
    end

    admin_section_forbidden
  end

  test "admin should destroy user" do
    autenticate_as_admin

    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:Tata).to_param
    end

    assert_redirected_to admin_users_path
  end
end
