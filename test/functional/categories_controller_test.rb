require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should view main category page" do
    get :index
    assert_response :success
  end

  test "should view sub category page" do
    get :show, { :id => categories(:Ore).to_param }
    assert_response :success
  end
end
