require "spec_helper"

describe CartsController do
  describe "routing" do

    it "routes to #index" do
      { :get => "/fr/profile/carts" }.should route_to("carts#index", :locale => "fr")
    end

    it "routes to #new" do
      { :get => "/fr/profile/carts/new" }.should route_to("carts#new", :locale => "fr")
    end

    it "routes to #show" do
      { :get => "/fr/profile/carts/42" }.should route_to("carts#show", :locale => "fr", :id => "42")
    end

    it "routes to #edit" do
      { :get => "/fr/profile/carts/42/edit" }.should route_to("carts#edit", :locale => "fr", :id => "42")
    end

    it "routes to #create" do
      { :post => "/fr/profile/carts" }.should route_to("carts#create", :locale => "fr")
    end

    it "routes to #update" do
      { :put => "/fr/profile/carts/42" }.should route_to("carts#update", :locale => "fr", :id => "42")
    end

    it "routes to #destroy" do
      { :delete => "/fr/profile/carts/42" }.should route_to("carts#destroy", :locale => "fr", :id => "42")
    end
  end
end
