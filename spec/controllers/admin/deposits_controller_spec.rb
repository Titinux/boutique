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

describe Admin::DepositsController do
  login_administrator

  let(:deposit) { create(:deposit) }

  describe "GET index" do
    it "assigns all deposits as @deposits" do
      get :index
      assigns(:deposits).should eq([deposit])
    end
  end

  describe "GET new" do
    it "assigns a new deposit as @deposit" do
      get :new
      assigns(:deposit).should be_a_new(Deposit)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        user  = deposit.user
        asset = create(:asset)

        @deposit_attributes = attributes_for(:deposit).merge({ :user_id => user.to_param,
                                                               :asset_id => asset.to_param })
      end

      it "creates a new Deposit" do
        expect {
          post :create, :deposit => @deposit_attributes
        }.to change(Deposit, :count).by(1)
      end

      it "assigns a newly created deposit as @deposit" do
        post :create, :deposit => @deposit_attributes

        assigns(:deposit).should be_a(Deposit)
        assigns(:deposit).should be_persisted
      end

      it "redirects to the list of deposits" do
        post :create, :deposit => @deposit_attributes
        response.should redirect_to(admin_deposits_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved deposit as @deposit" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, :deposit => {}
        assigns(:deposit).should be_a_new(Deposit)
      end

      it "re-renders the 'new' template" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, :deposit => {}
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested deposit" do
      deposit

      expect {
        delete :destroy, :id => deposit.to_param
      }.to change(Deposit, :count).by(-1)
    end

    it "redirects to the deposits list" do
      delete :destroy, :id => deposit.to_param
      response.should redirect_to(admin_deposits_url)
    end
  end
end
