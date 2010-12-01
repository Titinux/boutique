require "spec_helper"

describe Admin::CategoriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/fr/admin/categories" }.should route_to(:locale => "fr", :controller => "admin/categories", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/fr/admin/categories/new" }.should route_to(:locale => "fr", :controller => "admin/categories", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/fr/admin/categories/42" }.should route_to(:locale => "fr", :controller => "admin/categories", :action => "show", :id => "42")
    end

    it "recognizes and generates #edit" do
      { :get => "/fr/admin/categories/42/edit" }.should route_to(:locale => "fr", :controller => "admin/categories", :action => "edit", :id => "42")
    end

    it "recognizes and generates #create" do
      { :post => "/fr/admin/categories" }.should route_to(:locale => "fr", :controller => "admin/categories", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/fr/admin/categories/42" }.should route_to(:locale => "fr", :controller => "admin/categories", :action => "update", :id => "42")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/fr/admin/categories/42" }.should route_to(:locale => "fr", :controller => "admin/categories", :action => "destroy", :id => "42")
    end
  end
end
