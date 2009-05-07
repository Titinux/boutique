require 'test_helper'

class UserSessionControllerTest < ActionController::TestCase
  test "should get login" do
    get :new
    assert_response :success
  end

  test "should autenticate" do
    post :create, { :username => 'Boule', :password => 'boule' }
    assert user_session.login?
    assert_redirected_to root_url
  end

  test "should not autenticate with bad password" do
    post :create, { :username => 'Boule', :password => 'wrong' }
    assert !user_session.login?
    assert_redirected_to login_path
  end

  test "should logout" do
    autenticate_as_simple_user
    
    delete :destroy
    assert !user_session.login?
    assert_redirected_to root_url
  end

  test "authenticated user should view his profile" do
    autenticate_as_simple_user
    
    get :show
    assert_response :success
  end

  test "profile can\'t be diplayed without authenticated user"do
    get :show
    assert_redirected_to login_path
  end

end
