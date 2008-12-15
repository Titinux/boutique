require 'test_helper'

class DepositesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deposites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposite" do
    assert_difference('Deposite.count') do
      post :create, :deposite => { }
    end

    assert_redirected_to deposite_path(assigns(:deposite))
  end

  test "should show deposite" do
    get :show, :id => deposites(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => deposites(:one).id
    assert_response :success
  end

  test "should update deposite" do
    put :update, :id => deposites(:one).id, :deposite => { }
    assert_redirected_to deposite_path(assigns(:deposite))
  end

  test "should destroy deposite" do
    assert_difference('Deposite.count', -1) do
      delete :destroy, :id => deposites(:one).id
    end

    assert_redirected_to deposites_path
  end
end
