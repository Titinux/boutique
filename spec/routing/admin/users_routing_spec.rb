require "spec_helper"

describe Admin::UsersController do
  describe "routing" do
    it "routes to #index" do
      get("/fr/admin/users").should route_to("admin/users#index", :locale => "fr")
    end

    it "routes to #new" do
      get("/fr/admin/users/new").should route_to("admin/users#new", :locale => "fr")
    end

    it "routes to #show" do
      get("/fr/admin/users/42").should route_to("admin/users#show", :locale => "fr", :id => "42")
    end

    it "routes to #edit" do
      get("/fr/admin/users/42/edit").should route_to("admin/users#edit", :locale => "fr", :id => "42")
    end

    it "routes to #create" do
      post("/fr/admin/users").should route_to("admin/users#create", :locale => "fr")
    end

    it "routes to #update" do
      put("/fr/admin/users/42").should route_to("admin/users#update", :locale => "fr", :id => "42")
    end

    it "routes to #destroy" do
      delete("/fr/admin/users/42").should route_to("admin/users#destroy", :locale => "fr", :id => "42")
    end
  end
end
