require "spec_helper"

describe Admin::UsersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/fr/admin/users" }.should route_to(:locale => "fr", :controller => "admin/users", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/fr/admin/users/new" }.should route_to(:locale => "fr", :controller => "admin/users", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/fr/admin/users/42" }.should route_to(:locale => "fr", :controller => "admin/users", :action => "show", :id => "42")
    end

    it "recognizes and generates #edit" do
      { :get => "/fr/admin/users/42/edit" }.should route_to(:locale => "fr", :controller => "admin/users", :action => "edit", :id => "42")
    end

    it "recognizes and generates #create" do
      { :post => "/fr/admin/users" }.should route_to(:locale => "fr", :controller => "admin/users", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/fr/admin/users/42" }.should route_to(:locale => "fr", :controller => "admin/users", :action => "update", :id => "42")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/fr/admin/users/42" }.should route_to(:locale => "fr", :controller => "admin/users", :action => "destroy", :id => "42")
    end
  end
end
