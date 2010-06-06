require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test "should show statistics" do
    get :index
    assert_response :success
  end

  test "should show stock statistics" do
    get :show, { :id => "stock" }
    assert_response :success
  end
end
