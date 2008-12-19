require 'test_helper'

class AssetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assets)
  end

  test "should show asset" do
    get :show, :id => assets(:Fer).id
    assert_response :success
  end
end
