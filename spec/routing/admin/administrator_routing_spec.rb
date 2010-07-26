require "spec_helper"

describe Admin::AdministratorsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/administrators" }.should route_to(:controller => "admin/administrators", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/admin/administrators/new" }.should route_to(:controller => "admin/administrators", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/administrators/42" }.should route_to(:controller => "admin/administrators", :action => "show", :id => "42")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/administrators/42/edit" }.should route_to(:controller => "admin/administrators", :action => "edit", :id => "42")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/administrators" }.should route_to(:controller => "admin/administrators", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/administrators/42" }.should route_to(:controller => "admin/administrators", :action => "update", :id => "42")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/administrators/42" }.should route_to(:controller => "admin/administrators", :action => "destroy", :id => "42")
    end
  end
end
