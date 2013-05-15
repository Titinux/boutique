# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2011 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "spec_helper"

describe Admin::AssetsController do
  login_administrator

  let(:asset) { create(:asset) }
  let(:category) { asset.category }

  describe "GET index" do
    it "assigns all assets as @assets" do
      get :index
      assigns(:assets).should eq([asset])
    end
  end

  describe "GET show" do
    it "assigns the requested asset as @asset" do
      get :show, :id => asset.to_param
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
      get :edit, :id => asset.to_param
      assigns(:asset).should eq(asset)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Asset" do
        asset

        expect {
          post :create, :asset => attributes_for(:asset, category_id: category.id)
        }.to change(Asset, :count).by(1)
      end

      it "assigns a newly created asset as @asset" do
        post :create, :asset => attributes_for(:asset, category_id: category.id)
        assigns(:asset).should be_a(Asset)
        assigns(:asset).should be_persisted
      end

      it "redirects to the created asset" do
        post :create, :asset => attributes_for(:asset, category_id: category.id)

        response.should redirect_to([:admin, Asset.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved asset as @asset" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)
        post :create, :asset => {}

        assigns(:asset).should be_a_new(Asset)
      end

      it "re-renders the 'new' template" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, :user => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested asset" do
        Asset.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => asset.to_param, :asset => {'these' => 'params'}
      end

      it "assigns the requested asset as @asset" do
        put :update, :id => asset.to_param
        assigns(:asset).should eq(asset)
      end

      it "redirects to the asset" do
        put :update, :id => asset.to_param, :asset => attributes_for(:asset)
        response.should redirect_to([:admin, asset])
      end
    end

    describe "with invalid params" do
      it "assigns the asset as @asset" do
        Asset.any_instance.stub(:save).and_return(false)

        put :update, :id => asset.to_param, :asset => {}
        assigns(:asset).should eq(asset)
      end

      it "re-renders the 'edit' template" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        put :update, :id => asset.to_param, :asset => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested asset" do
      asset

      expect {
        delete :destroy, :id => asset.to_param
      }.to change(Asset, :count).by(-1)
    end

    it "redirects to the assets list" do
      delete :destroy, :id => asset.to_param
      response.should redirect_to(admin_assets_url)
    end
  end
end
