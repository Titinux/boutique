require "spec_helper"

describe Admin::DepositsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/fr/admin/deposits" }.should route_to(:locale => "fr", :controller => "admin/deposits", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/fr/admin/deposits/new" }.should route_to(:locale => "fr", :controller => "admin/deposits", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/fr/admin/deposits/42" }.should route_to(:locale => "fr", :controller => "admin/deposits", :action => "show", :id => "42")
    end

    it "not recognizes and generates #edit" do
      { :get => "/fr/admin/deposits/42/edit" }.should_not be_routable
    end

    it "recognizes and generates #create" do
      { :post => "/fr/admin/deposits" }.should route_to(:locale => "fr", :controller => "admin/deposits", :action => "create")
    end

    it "not recognizes and generates #update" do
      { :put => "/fr/admin/deposits/42" }.should_not be_routable
    end

    it "recognizes and generates #destroy" do
      { :delete => "/fr/admin/deposits/42" }.should route_to(:locale => "fr", :controller => "admin/deposits", :action => "destroy", :id => "42")
    end

    it "recognizes and generates #validate" do
      { :put => "/fr/admin/deposits/42/validate" }.should route_to(:locale => "fr", :controller => "admin/deposits", :action => "validate", :id => "42")
    end
  end
end
