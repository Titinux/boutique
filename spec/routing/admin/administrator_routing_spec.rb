require "spec_helper"

describe Admin::AdministratorsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/fr/admin/administrators" }.should route_to(:locale => "fr", :controller => "admin/administrators", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/fr/admin/administrators/new" }.should route_to(:locale => "fr", :controller => "admin/administrators", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/fr/admin/administrators/42" }.should route_to(:locale => "fr", :controller => "admin/administrators", :action => "show", :id => "42")
    end

    it "recognizes and generates #edit" do
      { :get => "/fr/admin/administrators/42/edit" }.should route_to(:locale => "fr", :controller => "admin/administrators", :action => "edit", :id => "42")
    end

    it "recognizes and generates #create" do
      { :post => "/fr/admin/administrators" }.should route_to(:locale => "fr", :controller => "admin/administrators", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/fr/admin/administrators/42" }.should route_to(:locale => "fr", :controller => "admin/administrators", :action => "update", :id => "42")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/fr/admin/administrators/42" }.should route_to(:locale => "fr", :controller => "admin/administrators", :action => "destroy", :id => "42")
    end
  end
end
