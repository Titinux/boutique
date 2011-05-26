require "spec_helper"

describe Admin::AssetsController do
  describe "routing" do
    it "routes to #index" do
      get("/fr/admin/assets").should route_to("admin/assets#index", :locale => "fr")
    end

    it "routes to #new" do
      get("/fr/admin/assets/new").should route_to("admin/assets#new", :locale => "fr")
    end

    it "routes to #show" do
      get("/fr/admin/assets/42").should route_to("admin/assets#show", :locale => "fr", :id => "42")
    end

    it "routes to #edit" do
      get("/fr/admin/assets/42/edit").should route_to("admin/assets#edit", :locale => "fr", :id => "42")
    end

    it "routes to #create" do
      post("/fr/admin/assets").should route_to("admin/assets#create", :locale => "fr")
    end

    it "routes to #update" do
      put("/fr/admin/assets/42").should route_to("admin/assets#update", :locale => "fr", :id => "42")
    end

    it "routes to #destroy" do
      delete("/fr/admin/assets/42").should route_to("admin/assets#destroy", :locale => "fr", :id => "42")
    end
  end
end
