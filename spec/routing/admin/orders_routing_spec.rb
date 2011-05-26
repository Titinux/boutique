require "spec_helper"

describe Admin::OrdersController do
  describe "routing" do
    it "routes to #index" do
      get("/fr/admin/orders").should route_to("admin/orders#index", :locale => "fr")
    end

    it "routes to #new" do
      get("/fr/admin/orders/new").should route_to("admin/orders#new", :locale => "fr")
    end

    it "routes to #show" do
      get("/fr/admin/orders/42").should route_to("admin/orders#show", :locale => "fr", :id => "42")
    end

    it "routes to #edit" do
      get("/fr/admin/orders/42/edit").should route_to("admin/orders#edit", :locale => "fr", :id => "42")
    end

    it "routes to #create" do
      post("/fr/admin/orders").should route_to("admin/orders#create", :locale => "fr")
    end

    it "routes to #update" do
      put("/fr/admin/orders/42").should route_to("admin/orders#update", :locale => "fr", :id => "42")
    end

    it "routes to #destroy" do
      delete("/fr/admin/orders/42").should route_to("admin/orders#destroy", :locale => "fr", :id => "42")
    end
  end
end
