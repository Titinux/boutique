require "spec_helper"

describe Admin::UsersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/users" }.should route_to(:controller => "admin/users", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/admin/users/new" }.should route_to(:controller => "admin/users", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/users/42" }.should route_to(:controller => "admin/users", :action => "show", :id => "42")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/users/42/edit" }.should route_to(:controller => "admin/users", :action => "edit", :id => "42")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/users" }.should route_to(:controller => "admin/users", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/users/42" }.should route_to(:controller => "admin/users", :action => "update", :id => "42")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/users/42" }.should route_to(:controller => "admin/users", :action => "destroy", :id => "42")
    end
  end
end
