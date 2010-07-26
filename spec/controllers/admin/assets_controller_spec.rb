require "spec_helper"

describe Admin::AssetsController do

  def mock_asset(stubs={})
    @mock_asset ||= mock_model(Asset, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all assets as @assets" do
      Asset.stub(:all) { [mock_asset] }
      get :index
      assigns(:assets).should eq([mock_asset])
    end
  end

  describe "GET show" do
    it "assigns the requested asset as @asset" do
      Asset.stub(:find).with("42") { mock_asset }
      get :show, :id => "42"
      assigns(:asset).should be(mock_asset)
    end
  end

  describe "GET new" do
    it "assigns a new asset as @asset" do
      Asset.stub(:new) { mock_asset }
      get :new
      assigns(:asset).should be(mock_asset)
    end
  end

  describe "GET edit" do
    it "assigns the requested asset as @asset" do
      Asset.stub(:find).with("37") { mock_asset }
      get :edit, :id => "37"
      assigns(:asset).should be(mock_asset)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created asset as @asset" do
        Asset.stub(:new).with({"these" => "params"}) { mock_asset(:save => true) }
        post :create, :asset => {"these" => "params"}
        assigns(:asset).should be(mock_asset)
      end

      it "redirects to the created asset" do
        Asset.stub(:new) { mock_asset(:save => true) }
        post :create, :asset => {}
        response.should redirect_to(admin_asset_url(mock_asset))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved asset as @asset" do
        Asset.stub(:new).with({"these" => "params"}) { mock_asset(:save => false) }
        post :create, :asset => {"these" => "params"}
        assigns(:asset).should be(mock_asset)
      end      

      it "re-renders the 'new' template" do
        Asset.stub(:new) { mock_asset(:save => false) }
        post :create, :asset => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested asset" do
        Asset.should_receive(:find).with("42") { mock_asset }
        mock_asset.should_receive(:update_attributes).with({"these" => "params"})
        put :update, :id => "42", :asset => {"these" => "params"}
      end

      it "assigns the requested asset as @asset" do
        Asset.stub(:find) { mock_asset(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:asset).should be(mock_asset)
      end

      it "redirects to the asset" do
        Asset.stub(:find) { mock_asset(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_asset_url(mock_asset))
      end
    end

    describe "with invalid params" do
      it "assigns the asset as @asset" do
        Asset.stub(:find) { mock_asset(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:asset).should be(mock_asset)
      end

      it "re-renders the 'edit' template" do
        Asset.stub(:find) { mock_asset(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested asset" do
      Asset.should_receive(:find).with("42") { mock_asset }
      mock_asset.should_receive(:destroy)
      delete :destroy, :id => "42"
    end

    it "redirects to the assets list" do
      Asset.stub(:find) { mock_asset }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_assets_url)
    end
  end
end
