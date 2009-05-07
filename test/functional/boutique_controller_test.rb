require 'test_helper'

class BoutiqueControllerTest < ActionController::TestCase
  test "should view welcome page" do
    get :welcome
    assert_response :success
  end
  
  test "should view main category page" do
    get :category
    assert_response :success
  end
  
  test "should view sub category page" do
    get :category, { :cat => categories(:Ore).id}
    assert_response :success
  end
end
