require "spec_helper"

describe Admin::GuildsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/guilds" }.should route_to(:controller => "admin/guilds", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/admin/guilds/new" }.should route_to(:controller => "admin/guilds", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/guilds/42" }.should route_to(:controller => "admin/guilds", :action => "show", :id => "42")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/guilds/42/edit" }.should route_to(:controller => "admin/guilds", :action => "edit", :id => "42")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/guilds" }.should route_to(:controller => "admin/guilds", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/guilds/42" }.should route_to(:controller => "admin/guilds", :action => "update", :id => "42")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/guilds/42" }.should route_to(:controller => "admin/guilds", :action => "destroy", :id => "42")
    end
  end
end
