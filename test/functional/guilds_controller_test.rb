require 'test_helper'

class GuildsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guilds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create guild" do
    assert_difference('Guild.count') do
      post :create, :guild => { }
    end

    assert_redirected_to guild_path(assigns(:guild))
  end

  test "should show guild" do
    get :show, :id => guilds(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => guilds(:one).id
    assert_response :success
  end

  test "should update guild" do
    put :update, :id => guilds(:one).id, :guild => { }
    assert_redirected_to guild_path(assigns(:guild))
  end

  test "should destroy guild" do
    assert_difference('Guild.count', -1) do
      delete :destroy, :id => guilds(:one).id
    end

    assert_redirected_to guilds_path
  end
end
