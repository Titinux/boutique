require "spec_helper"

describe CartController do
  describe "routing" do

    it "routes to #show" do
      { :get => "/fr/cart" }.should route_to("cart#show", :locale => "fr")
    end

    it "routes to #edit" do
      { :get => "/fr/cart/edit" }.should route_to("cart#edit", :locale => "fr")
    end

    it "routes to #update" do
      { :put => "/fr/cart" }.should route_to("cart#update", :locale => "fr")
    end

    it "routes to #destroy" do
      { :delete => "/fr/cart" }.should route_to("cart#destroy", :locale => "fr")
    end

    it "routes to #save" do
      { :get => "/fr/cart/save" }.should route_to("cart#save", :locale => "fr")
    end

    it "routes to #to_order" do
      { :get => "/fr/cart/to_order" }.should route_to("cart#to_order", :locale => "fr")
    end
  end
end
