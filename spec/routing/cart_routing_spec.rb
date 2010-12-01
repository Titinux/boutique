require "spec_helper"

describe CartController do
  describe "routing" do

    it "recognizes and generates #show" do
      { :get => "/fr/cart" }.should route_to(:locale => "fr", :controller => "cart", :action => "show")
    end

    it "recognizes and generates #edit" do
      { :get => "/fr/cart/edit" }.should route_to(:locale => "fr", :controller => "cart", :action => "edit")
    end

    it "recognizes and generates #update" do
      { :put => "/fr/cart" }.should route_to(:locale => "fr", :controller => "cart", :action => "update")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/fr/cart" }.should route_to(:locale => "fr", :controller => "cart", :action => "destroy")
    end

    it "recognizes and generates #save" do
      { :get => "/fr/cart/save" }.should route_to(:locale => "fr", :controller => "cart", :action => "save")
    end

    it "recognizes and generates #to_order" do
      { :get => "/fr/cart/to_order" }.should route_to(:locale => "fr", :controller => "cart", :action => "to_order")
    end
  end
end
