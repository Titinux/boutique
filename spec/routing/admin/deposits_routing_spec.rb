require "spec_helper"

describe Admin::DepositsController do
  describe "routing" do
    it "routes to #index" do
      get("/fr/admin/deposits").should route_to("admin/deposits#index", :locale => "fr")
    end

    it "routes to #new" do
      get("/fr/admin/deposits/new").should route_to("admin/deposits#new", :locale => "fr")
    end

    it "routes to #show" do
      get("/fr/admin/deposits/42").should route_to("admin/deposits#show", :locale => "fr", :id => "42")
    end

    it "does not routes to #edit" do
      get("/fr/admin/deposits/42/edit").should_not be_routable
    end

    it "routes to #create" do
      post("/fr/admin/deposits").should route_to("admin/deposits#create", :locale => "fr")
    end

    it "does not routes to #update" do
      put("/fr/admin/deposits/42").should_not be_routable
    end

    it "routes to #destroy" do
      delete("/fr/admin/deposits/42").should route_to("admin/deposits#destroy", :locale => "fr", :id => "42")
    end

    it "routes to #validate" do
      put("/fr/admin/deposits/42/validate").should route_to("admin/deposits#validate", :locale => "fr", :id => "42")
    end
  end
end
