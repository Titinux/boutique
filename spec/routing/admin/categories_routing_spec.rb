require "spec_helper"

describe Admin::CategoriesController do
  describe "routing" do
    it "routes to #index" do
      get("/fr/admin/categories").should route_to("admin/categories#index", :locale => "fr")
    end

    it "routes to #new" do
      get("/fr/admin/categories/new").should route_to("admin/categories#new", :locale => "fr")
    end

    it "routes to #show" do
      get("/fr/admin/categories/42").should route_to("admin/categories#show", :locale => "fr", :id => "42")
    end

    it "routes to #edit" do
      get("/fr/admin/categories/42/edit").should route_to("admin/categories#edit", :locale => "fr", :id => "42")
    end

    it "routes to #create" do
      post("/fr/admin/categories").should route_to("admin/categories#create", :locale => "fr")
    end

    it "routes to #update" do
      put("/fr/admin/categories/42").should route_to("admin/categories#update", :locale => "fr", :id => "42")
    end

    it "routes to #destroy" do
      delete("/fr/admin/categories/42").should route_to("admin/categories#destroy", :locale => "fr", :id => "42")
    end
  end
end
