require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should show category" do
    get :show, :id => categories(:Bois).id
    assert_response :success
  end
end
