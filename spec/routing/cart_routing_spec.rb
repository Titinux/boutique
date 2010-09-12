require "spec_helper"

describe CartController do
  describe "routing" do

    it "recognizes and generates #show" do
      { :get => "/cart" }.should route_to(:controller => "cart", :action => "show")
    end

    it "recognizes and generates #edit" do
      { :get => "/cart/edit" }.should route_to(:controller => "cart", :action => "edit")
    end

    it "recognizes and generates #update" do
      { :put => "/cart" }.should route_to(:controller => "cart", :action => "update")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cart" }.should route_to(:controller => "cart", :action => "destroy")
    end

    it "recognizes and generates #save" do
      { :get => "/cart/save" }.should route_to(:controller => "cart", :action => "save")
    end

    it "recognizes and generates #to_order" do
      { :get => "/cart/to_order" }.should route_to(:controller => "cart", :action => "to_order")
    end
  end
end
