require "spec_helper"

describe Admin::AssetsController do
  login_administrator

  describe "GET index" do
    it "assigns all assets as @assets" do
      asset = Factory :asset

      get :index
      assigns(:assets).to_a.should eq([asset])
    end
  end

  describe "GET show" do
    it "assigns the requested asset as @asset" do
      asset = Factory :asset

      get :show, :id => asset.id.to_s
      assigns(:asset).should eq(asset)
    end
  end

  describe "GET new" do
    it "assigns a new asset as @asset" do
      get :new
      assigns(:asset).should be_a_new(Asset)
    end
  end

  describe "GET edit" do
    it "assigns the requested asset as @asset" do
      asset = Factory :asset

      get :edit, :id => asset.id.to_s
      assigns(:asset).should eq(asset)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        category = Factory :category
        @asset_attributes = Factory.attributes_for(:asset).merge(:category_id => category.id.to_s)
      end

      it "creates a new Asset" do
        expect {
          post :create, :asset => @asset_attributes
        }.to change(Asset, :count).by(1)
      end

      it "assigns a newly created asset as @asset" do
        post :create, :asset => @asset_attributes
        assigns(:asset).should be_a(Asset)
        assigns(:asset).should be_persisted
      end

      it "redirects to the created asset" do
        post :create, :asset => @asset_attributes

        response.should redirect_to([:admin, Asset.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved asset as @asset" do
        Asset.any_instance.stub(:save).and_return(false)
        post :create, :asset => {}

        assigns(:asset).should be_a_new(Asset)
      end

      it "re-renders the 'new' template" do
        Asset.any_instance.stub(:save).and_return(false)
        Asset.any_instance.stub(:errors).and_return({'error' => 'foo'})

        post :create, :user => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested asset" do
        asset = Factory :asset

        Asset.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => asset.id.to_s, :asset => {'these' => 'params'}
      end

      it "assigns the requested asset as @asset" do
        asset = Factory :asset

        put :update, :id => asset.id.to_s
        assigns(:asset).should eq(asset)
      end

      it "redirects to the asset" do
        asset = Factory :asset

        put :update, :id => asset.id.to_s, :asset => Factory.attributes_for(:asset)
        response.should redirect_to([:admin, asset])
      end
    end

    describe "with invalid params" do
      it "assigns the asset as @asset" do
        asset = Factory :asset
        Asset.any_instance.stub(:save).and_return(false)

        put :update, :id => asset.id.to_s, :asset => {}
        assigns(:asset).should eq(asset)
      end

      it "re-renders the 'edit' template" do
        asset = Factory :asset
        Asset.any_instance.stub(:save).and_return(false)
        Asset.any_instance.stub(:errors).and_return({ 'error' => 'foo'})

        put :update, :id => asset.id.to_s, :asset => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested asset" do
      asset = Factory :asset

      expect {
        delete :destroy, :id => asset.id.to_s
      }.to change(Asset, :count).by(-1)
    end

    it "redirects to the assets list" do
      asset = Factory :asset

      delete :destroy, :id => asset.id.to_s
      response.should redirect_to(admin_assets_url)
    end
  end
end
