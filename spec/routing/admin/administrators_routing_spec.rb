require "spec_helper"

describe Admin::AdministratorsController do
  describe "routing" do
    it "routes to #index" do
      get("/fr/admin/administrators").should route_to("admin/administrators#index", :locale => "fr")
    end

    it "routes to #new" do
      get("/fr/admin/administrators/new").should route_to("admin/administrators#new", :locale => "fr")
    end

    it "routes to #show" do
      get("/fr/admin/administrators/42").should route_to("admin/administrators#show", :locale => "fr", :id => "42")
    end

    it "routes to #edit" do
      get("/fr/admin/administrators/42/edit").should route_to("admin/administrators#edit", :locale => "fr", :id => "42")
    end

    it "routes to #create" do
      post("/fr/admin/administrators").should route_to("admin/administrators#create", :locale => "fr")
    end

    it "routes to #update" do
      put("/fr/admin/administrators/42").should route_to("admin/administrators#update", :locale => "fr", :id => "42")
    end

    it "routes to #destroy" do
      delete("/fr/admin/administrators/42").should route_to("admin/administrators#destroy", :locale => "fr", :id => "42")
    end
  end
end
