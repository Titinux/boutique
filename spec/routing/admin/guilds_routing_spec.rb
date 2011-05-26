require "spec_helper"

describe Admin::GuildsController do
  describe "routing" do
    it "routes to #index" do
      get("/fr/admin/guilds").should route_to("admin/guilds#index", :locale => "fr")
    end

    it "routes to #new" do
      get("/fr/admin/guilds/new").should route_to("admin/guilds#new", :locale => "fr")
    end

    it "routes to #show" do
      get("/fr/admin/guilds/42").should route_to("admin/guilds#show", :locale => "fr", :id => "42")
    end

    it "routes to #edit" do
      get("/fr/admin/guilds/42/edit").should route_to("admin/guilds#edit", :locale => "fr", :id => "42")
    end

    it "routes to #create" do
      post("/fr/admin/guilds").should route_to("admin/guilds#create", :locale => "fr")
    end

    it "routes to #update" do
      put("/fr/admin/guilds/42").should route_to("admin/guilds#update", :locale => "fr", :id => "42")
    end

    it "routes to #destroy" do
      delete("/fr/admin/guilds/42").should route_to("admin/guilds#destroy", :locale => "fr", :id => "42")
    end
  end
end
