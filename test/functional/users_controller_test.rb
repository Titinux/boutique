require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "authenticated user should show profile" do
    autenticate_as_simple_user
    
    get :show
    assert_response :success
  end

  test "unautenticated user shouldn't show profile"do
    get :show

    unautenticated_forbidden
  end

  test "authenticated user should get edit profile" do
    autenticate_as_simple_user
    
    get :show
    assert_response :success
  end

  test "unautenticated user shouldn't get edit profile"do
    get :edit
    
    unautenticated_forbidden
  end

  test "authenticated user should update profile" do
    autenticate_as_simple_user
    
    put :update, :user => {
                          :password => 'tructructruc',
                          :password_confirmation => 'tructructruc',
                          :email => 'truc@chose.com',
                          :guild_id => guilds(:Famakna_food).id
                          }
                          
    assert_redirected_to user_path
  end

  test "unauthenticated user should update profile" do
    put :update, :user => {
                          :password => 'truc',
                          :password_confirmation => 'truc',
                          :email => 'truc@chose.com',
                          :guild_id => guilds(:Famakna_food).id
                          }
                          
    unautenticated_forbidden
  end

  test "user should active is account" do
    get :activate, :key => users('Poum').activationKey
    
    assert_redirected_to login_path
  end

end
