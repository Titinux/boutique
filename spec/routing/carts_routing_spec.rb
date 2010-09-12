require "spec_helper"

describe CartsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/profile/carts" }.should route_to(:controller => "carts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/profile/carts/new" }.should route_to(:controller => "carts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/profile/carts/42" }.should route_to(:controller => "carts", :action => "show", :id => "42")
    end

    it "recognizes and generates #edit" do
      { :get => "/profile/carts/42/edit" }.should route_to(:controller => "carts", :action => "edit", :id => "42")
    end

    it "recognizes and generates #create" do
      { :post => "/profile/carts" }.should route_to(:controller => "carts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/profile/carts/42" }.should route_to(:controller => "carts", :action => "update", :id => "42")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/profile/carts/42" }.should route_to(:controller => "carts", :action => "destroy", :id => "42")
    end
  end
end
