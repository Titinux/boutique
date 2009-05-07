require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  test "simple user shouldn't get index" do
    autenticate_as_simple_user
    
    get :index
    
    admin_section_forbidden
  end
  
  test "admin should get index" do
    autenticate_as_admin
    
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "simple user shouldn't get new" do
    autenticate_as_simple_user
    
    get :new
    
    admin_section_forbidden
  end

  test "admin should get new" do
    autenticate_as_admin
    
    get :new
    assert_response :success
  end

  test "simple user souldn't create category" do
    autenticate_as_simple_user
    
    assert_no_difference('Category.count') do
      post :create, :category => { :name => 'Potions' }
    end

    admin_section_forbidden
  end

  test "admin should create category" do
    autenticate_as_admin
    
    assert_difference('Category.count') do
      post :create, :category => { :name => 'Potions' }
    end

    assert_redirected_to admin_category_path(assigns(:category))
  end

  test "simple user souldn't show category" do
    autenticate_as_simple_user
    
    get :show, :id => categories(:Wood).id
    
    admin_section_forbidden
  end

  test "admin should show category" do
    autenticate_as_admin
    
    get :show, :id => categories(:Wood).id
    assert_response :success
  end

  test "simple user shouldn't get edit" do
    autenticate_as_simple_user
    
    get :edit, :id => categories(:Wood).id
    
    admin_section_forbidden
  end

  test "admin should get edit" do
    autenticate_as_admin
    
    get :edit, :id => categories(:Wood).id
    assert_response :success
  end

  test "simple user shouldn't update category" do
    autenticate_as_simple_user
    
    put :update, :id => categories(:Wood).id, :category => { :name => 'Foobar' }
    
    admin_section_forbidden
  end

  test "admin should update category" do
    autenticate_as_admin
    
    put :update, :id => categories(:Wood).id, :category => { :name => 'Foobar' }
    assert_redirected_to admin_category_path(assigns(:category))
  end

  test "simple user shouldn't destroy category" do
    autenticate_as_simple_user
    
    assert_no_difference('Category.count') do
      delete :destroy, :id => categories(:Wood).id
    end
    
    admin_section_forbidden
  end

  test "admin should destroy category" do
    autenticate_as_admin
    
    assert_difference('Category.count', -1) do
      delete :destroy, :id => categories(:Wood).id
    end

    assert_redirected_to admin_categories_path
  end
end
