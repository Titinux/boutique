require 'test_helper'

class BoutiqueControllerTest < ActionController::TestCase
  test "should view welcome page" do
    get :show
    assert_response :success
  end
end
