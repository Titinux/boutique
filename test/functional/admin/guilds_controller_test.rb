require 'test_helper'

class Admin::GuildsControllerTest < ActionController::TestCase
  test "simple user shouldn't get index" do
    autenticate_as_simple_user

    get :index

    admin_section_forbidden
  end

  test "admin should get index" do
    autenticate_as_admin

    get :index
    assert_response :success
    assert_not_nil assigns(:guilds)
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

  test "simple user shouldn't create guild" do
    autenticate_as_simple_user

    assert_no_difference('Guild.count') do
      post :create, :guild => { :name => 'Foobar guild', :pictureUri => '' }
    end

    admin_section_forbidden
  end

  test "admin should create guild" do
    autenticate_as_admin

    assert_difference('Guild.count') do
      post :create, :guild => { :name => 'Foobar guild', :pictureUri => '' }
    end

    assert_redirected_to admin_guild_path(assigns(:guild))
  end

  test "simple user shouldn't show guild" do
    autenticate_as_simple_user

    get :show, :id => guilds(:Famakna_food).to_param

    admin_section_forbidden
  end

  test "admin should show guild" do
    autenticate_as_admin

    get :show, :id => guilds(:Famakna_food).to_param
    assert_response :success
  end

  test "simple user shouldn't get edit" do
    autenticate_as_simple_user

    get :edit, :id => guilds(:Famakna_food).to_param

    admin_section_forbidden
  end

  test "admin should get edit" do
    autenticate_as_admin

    get :edit, :id => guilds(:Famakna_food).to_param
    assert_response :success
  end

  test "simple user shouldn't update guild" do
    autenticate_as_simple_user

    put :update, :id => guilds(:Famakna_food).to_param, :guild => { :name => 'Foo guild' }

    admin_section_forbidden
  end

  test "should update guild" do
    autenticate_as_admin

    put :update, :id => guilds(:Famakna_food).to_param, :guild => { :name => 'Foo guild' }
    assert_redirected_to admin_guild_path(assigns(:guild))
  end

  test "simple user shouldn't destroy guild" do
    autenticate_as_simple_user

    assert_no_difference('Guild.count') do
      delete :destroy, :id => guilds(:Famakna_food).to_param
    end

    admin_section_forbidden
  end

  test "admin should destroy guild" do
    autenticate_as_admin

    assert_difference('Guild.count', -1) do
      delete :destroy, :id => guilds(:Famakna_food).to_param
    end

    assert_redirected_to admin_guilds_path
  end
end
