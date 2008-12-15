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
      post :create, :guild => { :name => 'Nouvelle guilde', :pictureUri => '' }
    end

    assert_redirected_to guild_path(assigns(:guild))
  end

  test "should show guild" do
    get :show, :id => guilds(:Famakna_food).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => guilds(:Famakna_food).id
    assert_response :success
  end

  test "should update guild" do
    put :update, :id => guilds(:Famakna_food).id, :guild => { :name => 'Famakna mood'}
    assert_redirected_to guild_path(assigns(:guild))
  end

  test "should destroy guild" do
    assert_difference('Guild.count', -1) do
      delete :destroy, :id => guilds(:Famakna_food).id
    end

    assert_redirected_to guilds_path
  end
end
