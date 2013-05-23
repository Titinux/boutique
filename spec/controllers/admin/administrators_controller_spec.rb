# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2013 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
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

describe Admin::AdministratorsController do
  login_administrator

  let(:administrator) { create(:administrator) }

  describe "GET index" do
    it "assigns all administrators as @administrators" do
      get :index, {}
      assigns(:administrators).should eq([subject.current_administrator, administrator])
    end
  end

  describe "GET show" do
    it "assigns the requested administrator as @administrator" do
      get :show, {:id => administrator.to_param}
      assigns(:administrator).should eq(administrator)
    end
  end

  describe "GET new" do
    it "assigns a new administrator as @administrator" do
      get :new, {}
      assigns(:administrator).should be_a_new(Administrator)
    end
  end

  describe "GET edit" do
    it "assigns the requested administrator as @administrator" do
      get :edit, {:id => administrator.to_param}
      assigns(:administrator).should eq(administrator)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Administrator" do
        expect {
          post :create, {:administrator => attributes_for(:administrator)}
        }.to change(Administrator, :count).by(1)
      end

      it "assigns a newly created administrator as @administrator" do
        post :create, {:administrator => attributes_for(:administrator)}
        assigns(:administrator).should be_a(Administrator)
        assigns(:administrator).should be_persisted
      end

      it "redirects to the created administrator" do
        post :create, {:administrator => attributes_for(:administrator)}
        response.should redirect_to([:admin, Administrator.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved administrator as @administrator" do
        # Trigger the behavior that occurs when invalid params are submitted
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, {:administrator => { "name" => "invalid value" }}
        assigns(:administrator).should be_a_new(Administrator)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, {:administrator => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested administrator" do
        # Assuming there are no other administrators in the database, this
        # specifies that the Administrator created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Administrator.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => administrator.to_param, :administrator => { "name" => "MyString" }}
      end

      it "assigns the requested administrator as @administrator" do
        put :update, {:id => administrator.to_param, :administrator => attributes_for(:administrator)}
        assigns(:administrator).should eq(administrator)
      end

      it "redirects to the administrator" do
        put :update, {:id => administrator.to_param, :administrator => attributes_for(:administrator)}
        response.should redirect_to([:admin, administrator])
      end
    end

    describe "with invalid params" do
      it "assigns the administrator as @administrator" do
        # Trigger the behavior that occurs when invalid params are submitted
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        put :update, {:id => administrator.to_param, :administrator => { "name" => "invalid value" }}
        assigns(:administrator).should eq(administrator)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        put :update, {:id => administrator.to_param, :administrator => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested administrator" do
      administrator

      expect {
        delete :destroy, {:id => administrator.to_param}
      }.to change(Administrator, :count).by(-1)
    end

    it "redirects to the administrators list" do
    delete :destroy, {:id => administrator.to_param}
      response.should redirect_to(admin_administrators_url)
    end
  end

end

