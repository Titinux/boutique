require "spec_helper"

describe Admin::AdministratorsController do

  def mock_administrator(stubs={})
    @mock_administrator ||= mock_model(Administrator, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all administrators as @administrators" do
      Administrator.stub(:where) { [mock_administrator] }
      get :index
      assigns(:administrators).should eq([mock_administrator])
    end
  end

  describe "GET show" do
    it "assigns the requested administrator as @administrator" do
      Administrator.stub(:find).with("42") { mock_administrator }
      get :show, :id => "42"
      assigns(:administrator).should be(mock_administrator)
    end
  end

  describe "GET new" do
    it "assigns a new administrator as @administrator" do
      Administrator.stub(:new) { mock_administrator }
      get :new
      assigns(:administrator).should be(mock_administrator)
    end
  end

  describe "GET edit" do
    it "assigns the requested administrator as @administrator" do
      Administrator.stub(:find).with("37") { mock_administrator }
      get :edit, :id => "37"
      assigns(:administrator).should be(mock_administrator)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created administrator as @administrator" do
        Administrator.stub(:new).with({"these" => "params"}) { mock_administrator(:save => true) }
        post :create, :administrator => {"these" => "params"}
        assigns(:administrator).should be(mock_administrator)
      end

      it "redirects to the created administrator" do
        Administrator.stub(:new) { mock_administrator(:save => true) }
        post :create, :administrator => {}
        response.should redirect_to(admin_administrator_url(mock_administrator))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved administrator as @administrator" do
        Administrator.stub(:new).with({"these" => "params"}) { mock_administrator(:save => false) }
        post :create, :administrator => {"these" => "params"}
        assigns(:administrator).should be(mock_administrator)
      end

      it "re-renders the 'new' template" do
        Administrator.stub(:new) { mock_administrator(:save => false) }
        post :create, :administrator => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested administrator" do
        Administrator.should_receive(:find).with("42") { mock_administrator }
        mock_administrator.should_receive(:update_attributes).with({"these" => "params"})
        put :update, :id => "42", :administrator => {"these" => "params"}
      end

      it "assigns the requested administrator as @administrator" do
        Administrator.stub(:find) { mock_administrator(:update_attributes => true) }
        put :update, :id => "42", :administrator => {"these" => "params"}
        assigns(:administrator).should be(mock_administrator)
      end

      it "redirects to the administrator" do
        Administrator.stub(:find) { mock_administrator(:update_attributes => true) }
        put :update, :id => "42", :administrator => {"these" => "params"}
        response.should redirect_to(admin_administrator_url(mock_administrator))
      end
    end

    describe "with invalid params" do
      it "assigns the administrator as @administrator" do
        Administrator.stub(:find) { mock_administrator(:update_attributes => false) }
        put :update, :id => "42", :administrator => {"these" => "params"}
        assigns(:administrator).should be(mock_administrator)
      end

      it "re-renders the 'edit' template" do
        Administrator.stub(:find) { mock_administrator(:update_attributes => false) }
        put :update, :id => "42", :administrator => {"these" => "params"}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested administrator" do
      Administrator.should_receive(:find).with("42") { mock_administrator }
      mock_administrator.should_receive(:destroy)
      delete :destroy, :id => "42"
    end

    it "redirects to the administrators list" do
      Administrator.stub(:find) { mock_administrator }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_administrators_url)
    end
  end
end
