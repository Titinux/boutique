# encoding: utf-8

require 'test_helper'

class Admin::AssetsControllerTest < ActionController::TestCase
  test "admin should get index" do
    autenticate_as_admin

    get :index
    assert_response :success
    assert_not_nil assigns(:assets)
  end

  test "simple user shouldn't get index" do
    autenticate_as_simple_user

    get :index

    admin_section_forbidden
  end


  test "admin should get new" do
    autenticate_as_admin

    get :new
    assert_response :success
  end

  test "simple user shouldn't get new" do
    autenticate_as_simple_user

    get :new
    assert_redirected_to root_path
  end

  test "simple user shouldn't create asset" do
    autenticate_as_simple_user

    assert_no_difference('Asset.count') do
      post :create, :asset => { :name => 'Chêne',
                                :category => categories(:Wood),
                                :pictureUri => 'assets/wood/walnut_wood.png',
                                :unitaryPrice => 10.99,
                                :floatPrice => false
                              }
    end

    admin_section_forbidden
  end

  test "admin should create asset" do
    autenticate_as_admin

    assert_difference('Asset.count') do
      post :create, :asset => { :name => 'Chêne',
                                :category => categories(:Wood),
                                :pictureUri => 'assets/wood/walnut_wood.png',
                                :unitaryPrice => 10.99,
                                :floatPrice => false
                              }
    end

    assert flash[:notice].include?("Asset was successfully created.")

    assert_redirected_to admin_asset_path(assigns(:asset))
  end

  test "simple user shouldn't show asset" do
    autenticate_as_simple_user

    get :show, :id => assets(:Iron).to_param
    admin_section_forbidden
  end

  test "admin should show asset" do
    autenticate_as_admin

    get :show, :id => assets(:Iron).to_param
    assert_response :success
  end

  test "simple user shouldn't get edit" do
    autenticate_as_simple_user

    get :edit, :id => assets(:Iron).to_param
    admin_section_forbidden
  end

  test "admin should get edit" do
    autenticate_as_admin

    get :edit, :id => assets(:Iron).to_param
    assert_response :success
  end

  test "simple user shouldn't update asset" do
    autenticate_as_simple_user

    put :update, :id => assets(:Chestnut).to_param, :asset => {
                               :category => categories(:Ore),
                               :pictureUri => '',
                               :unitaryPrice => 5,
                               :floatPrice => false
                              }
    admin_section_forbidden
  end

  test "admin should update asset" do
    autenticate_as_admin

    put :update, :id => assets(:Chestnut).to_param, :asset => {
                               :category => categories(:Ore),
                               :pictureUri => '',
                               :unitaryPrice => 5,
                               :floatPrice => false
                              }

    assert_redirected_to admin_asset_path(assets(:Chestnut).to_param)
  end

  test "simple user shouldn't destroy asset" do
    autenticate_as_simple_user

    assert_no_difference('Asset.count') do
      delete :destroy, :id => assets(:Iron).to_param
    end

    admin_section_forbidden
  end

  test "admin should destroy asset" do
    autenticate_as_admin

    assert_difference('Asset.count', -1) do
      delete :destroy, :id => assets(:Iron).to_param
    end

    assert_redirected_to admin_assets_path
  end
end
