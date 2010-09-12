require "spec_helper"

describe Admin::AssetsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/assets" }.should route_to(:controller => "admin/assets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/assets/new" }.should route_to(:controller => "admin/assets", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/assets/42" }.should route_to(:controller => "admin/assets", :action => "show", :id => "42")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/assets/42/edit" }.should route_to(:controller => "admin/assets", :action => "edit", :id => "42")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/assets" }.should route_to(:controller => "admin/assets", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/assets/42" }.should route_to(:controller => "admin/assets", :action => "update", :id => "42")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/assets/42" }.should route_to(:controller => "admin/assets", :action => "destroy", :id => "42")
    end
  end
end
