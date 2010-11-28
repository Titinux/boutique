require "spec_helper"

describe Admin::CategoriesController do

  def mock_category(stubs={})
    @mock_category ||= mock_model(Category, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      Category.stub(:all) { [mock_category] }
      get :index
      assigns(:categories).should eq([mock_category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      Category.stub(:find).with("42") { mock_category }
      get :show, :id => "42"
      assigns(:category).should be(mock_category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      Category.stub(:new) { mock_category }
      get :new
      assigns(:category).should be(mock_category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      Category.stub(:find).with("37") { mock_category }
      get :edit, :id => "37"
      assigns(:category).should be(mock_category)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created category as @category" do
        Category.stub(:new).with({"these" => "params"}) { mock_category(:save => true) }
        post :create, :category => {"these" => "params"}
        assigns(:category).should be(mock_category)
      end

      it "redirects to the created category" do
        Category.stub(:new) { mock_category(:save => true) }
        post :create, :category => {}
        response.should redirect_to(admin_category_url(mock_category))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        Category.stub(:new).with({"these" => "params"}) { mock_category(:save => false) }
        post :create, :category => {"these" => "params"}
        assigns(:category).should be(mock_category)
      end

      it "re-renders the 'new' template" do
        Category.stub(:new) { mock_category(:save => false) }
        post :create, :category => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested category" do
        Category.should_receive(:find).with("42") { mock_category }
        mock_category.should_receive(:update_attributes).with({"these" => "params"})
        put :update, :id => "42", :category => {"these" => "params"}
      end

      it "assigns the requested category as @category" do
        Category.stub(:find) { mock_category(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:category).should be(mock_category)
      end

      it "redirects to the category" do
        Category.stub(:find) { mock_category(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_category_url(mock_category))
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        Category.stub(:find) { mock_category(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:category).should be(mock_category)
      end

      it "re-renders the 'edit' template" do
        Category.stub(:find) { mock_category(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      Category.should_receive(:find).with("42") { mock_category }
      mock_category.should_receive(:destroy)
      delete :destroy, :id => "42"
    end

    it "redirects to the categories list" do
      Category.stub(:find) { mock_category }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_categories_url)
    end
  end
end