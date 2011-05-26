require "spec_helper"

describe Admin::CategoriesController do
  login_administrator

  describe "GET index" do
    it "assigns all categories as @categories" do
      category = Factory :category

      get :index
      assigns(:categories).to_a.should eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category = Factory :category

      get :show, :id => category.id.to_s
      assigns(:category).should eq(category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new
      assigns(:category).should be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      category = Factory :category
      get :edit, :id => category.id.to_s
      assigns(:category).should eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, :category => Factory.attributes_for(:category)
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, :category => Factory.attributes_for(:category)
        assigns(:category).should be_a(Category)
        assigns(:category).should be_persisted
      end

      it "redirects to the created category" do
        post :create, :category => Factory.attributes_for(:category)
        response.should redirect_to([:admin, Category.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        Category.any_instance.stub(:save).and_return(false)
        post :create, :category => {}
        assigns(:category).should be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        Category.any_instance.stub(:save).and_return(false)
        Category.any_instance.stub(:errors).and_return({ 'error' => 'foo'})

        post :create, :category => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested category" do
        category = Factory :category

        Category.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => category.id.to_s, :category => {'these' => 'params'}
      end

      it "assigns the requested category as @category" do
        category = Factory :category

        put :update, :id => category.id.to_s, :category => Factory.attributes_for(:category)
        assigns(:category).should eq(category)
      end

      it "redirects to the category" do
        category = Factory :category

        put :update, :id => category.id.to_s, :category => Factory.attributes_for(:category)
        response.should redirect_to([:admin, category])
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        category = Factory :category
        Category.any_instance.stub(:save).and_return(false)

        put :update, :id => category.id.to_s, :category => {}
        assigns(:category).should eq(category)
      end

      it "re-renders the 'edit' template" do
        category = Factory :category
        Category.any_instance.stub(:save).and_return(false)
        Category.any_instance.stub(:errors).and_return({ 'error' => 'foo'})

        put :update, :id => category.id.to_s, :category => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = Factory :category

      expect {
        delete :destroy, :id => category.id.to_s
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Factory :category

      delete :destroy, :id => category.id.to_s
      response.should redirect_to(admin_categories_url)
    end
  end
end
