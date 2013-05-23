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

describe Admin::GuildsController do
  login_administrator

  let(:guild) { create(:guild) }

  describe "GET index" do
    it "assigns all guilds as @guilds" do
      get :index
      assigns(:guilds).should eq([guild])
    end
  end

  describe "GET show" do
    it "assigns the requested guild as @guild" do
      get :show, :id => guild.to_param
      assigns(:guild).should eq(guild)
    end
  end

  describe "GET new" do
    it "assigns a new guild as @guild" do
      get :new
      assigns(:guild).should be_a_new(Guild)
    end
  end

  describe "GET edit" do
    it "assigns the requested guild as @guild" do
      get :edit, :id => guild.to_param
      assigns(:guild).should eq(guild)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Guild" do
        expect {
          post :create, :guild => attributes_for(:guild)
        }.to change(Guild, :count).by(1)
      end

      it "assigns a newly created guild as @guild" do
        post :create, :guild => attributes_for(:guild)
        assigns(:guild).should be_a(Guild)
        assigns(:guild).should be_persisted
      end

      it "redirects to the created guild" do
        post :create, :guild => attributes_for(:guild)
        response.should redirect_to([:admin, Guild.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved guild as @guild" do
        Guild.any_instance.stub(:valid?).and_return(false)

        post :create, :guild => { "name" => "invalid value" }
        assigns(:guild).should be_a_new(Guild)
      end

      it "re-renders the 'new' template" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, :guild => { "name" => "invalid value" }
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested guild" do
        Guild.any_instance.should_receive(:update_attributes).with({'name' => 'params'})
        put :update, :id => guild.to_param, :guild => {'name' => 'params'}
      end

      it "assigns the requested guild as @guild" do
        put :update, :id => guild.to_param, :guild => attributes_for(:guild)
        assigns(:guild).should eq(guild)
      end

      it "redirects to the guild" do
        put :update, :id => guild.to_param, :guild => attributes_for(:guild)
        response.should redirect_to([:admin, guild])
      end
    end

    describe "with invalid params" do
      it "assigns the guild as @guild" do
        guild
        Guild.any_instance.stub(:valid?).and_return(false)

        put :update, :id => guild.to_param, :guild => { "name" => "invalid value" }
        assigns(:guild).should eq(guild)
      end

      it "re-renders the 'edit' template" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        put :update, :id => guild.to_param, :guild => { "name" => "invalid value" }
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested guild" do
      guild

      expect {
        delete :destroy, :id => guild.to_param
      }.to change(Guild, :count).by(-1)
    end

    it "redirects to the guilds list" do
      delete :destroy, :id => guild.to_param
      response.should redirect_to(admin_guilds_url)
    end
  end
end
