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

describe Admin::CategoriesController do
  login_administrator

  let(:category) { create(:category) }

  describe "GET index" do
    it "assigns all categories as @categories" do
      get :index
      assigns(:categories).should eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      get :show, :id => category.to_param
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
      get :edit, :id => category.to_param
      assigns(:category).should eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        category

        expect {
          post :create, :category => attributes_for(:category)
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, :category => attributes_for(:category)
        assigns(:category).should be_a(Category)
        assigns(:category).should be_persisted
      end

      it "redirects to the created category" do
        post :create, :category => attributes_for(:category)
        response.should redirect_to([:admin, Category.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, :category => {}
        assigns(:category).should be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        post :create, :category => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested category" do
        Category.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => category.to_param, :category => {'these' => 'params'}
      end

      it "assigns the requested category as @category" do
        put :update, :id => category.to_param, :category => attributes_for(:category)
        assigns(:category).should eq(category)
      end

      it "redirects to the category" do
        put :update, :id => category.to_param, :category => attributes_for(:category)
        response.should redirect_to([:admin, category])
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        put :update, :id => category.to_param, :category => {}
        assigns(:category).should eq(category)
      end

      it "re-renders the 'edit' template" do
        subject.responder.any_instance.stub(:has_errors?).and_return(true)

        put :update, :id => category.to_param, :category => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category

      expect {
        delete :destroy, :id => category.to_param
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      delete :destroy, :id => category.to_param
      response.should redirect_to(admin_categories_url)
    end
  end
end
