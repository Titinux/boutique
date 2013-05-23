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

describe Admin::UsersController do
  login_administrator

  let(:user) { create(:user) }

  describe "GET index" do
    it "assigns all users as @users" do
      get :index
      assigns(:users).should eq([user])
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      get :show, :id => user.to_param
      assigns(:user).should eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit, :id => user.to_param
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, :user => attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, :user => attributes_for(:user)
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, :user => attributes_for(:user)
        response.should redirect_to([:admin, User.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, :user => { "name" => "invalid value" }
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, :user => { "name" => "invalid value" }
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        User.any_instance.should_receive(:update_attributes).with({'name' => 'params'})
        put :update, :id => user.to_param, :user => {'name' => 'params'}
      end

      it "assigns the requested user as @user" do
        put :update, :id => user.to_param, :user => attributes_for(:user)
        assigns(:user).should eq(user)
      end

      it "redirects to the user" do
        put :update, :id => user.to_param, :user => attributes_for(:user)
        response.should redirect_to([:admin, user])
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        put :update, :id => user.to_param, :user => { "name" => "invalid value" }
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        put :update, :id => user.to_param, :user => { "name" => "invalid value" }
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user

      expect {
        delete :destroy, :id => user.to_param
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, :id => user.to_param
      response.should redirect_to(admin_users_url)
    end
  end
end
