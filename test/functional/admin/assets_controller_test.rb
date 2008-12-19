require 'test_helper'

class Admin::AssetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset" do
    assert_difference('Asset.count') do
      post :create, :asset => { :name => 'Chêne',
                                :category => categories(:Bois),
                                :pictureUri => '',
                                :unitaryPrice => 10.99,
                                :floatPrice => false
                              }
    end

    assert_redirected_to admin_asset_path(assigns(:asset))
  end

  test "should show asset" do
    get :show, :id => assets(:Fer).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => assets(:Fer).id
    assert_response :success
  end

  test "should update asset" do
    put :update, :id => assets(:Noyer).id, :asset => { :name => 'Cuivre',
                                :category => categories(:Minerai),
                                :pictureUri => '',
                                :unitaryPrice => 5,
                                :floatPrice => false
                              }
    assert_redirected_to admin_asset_path(assigns(:asset))
  end

  test "should destroy asset" do
    assert_difference('Asset.count', -1) do
      delete :destroy, :id => assets(:Fer).id
    end

    assert_redirected_to admin_assets_path
  end
end
