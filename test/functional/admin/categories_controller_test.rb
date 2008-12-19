require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, :category => { :name => 'Potions' }
    end

    assert_redirected_to admin_category_path(assigns(:category))
  end

  test "should show category" do
    get :show, :id => categories(:Bois).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => categories(:Bois).id
    assert_response :success
  end

  test "should update category" do
    put :update, :id => categories(:Bois).id, :category => { :name => 'Wood' }
    assert_redirected_to admin_category_path(assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, :id => categories(:Bois).id
    end

    assert_redirected_to admin_categories_path
  end
end
