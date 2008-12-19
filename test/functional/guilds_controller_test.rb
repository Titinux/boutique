require 'test_helper'

class GuildsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guilds)
  end

  test "should show guild" do
    get :show, :id => guilds(:Famakna_food).id
    assert_response :success
  end
end
