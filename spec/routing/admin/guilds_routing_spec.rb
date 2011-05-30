# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2011 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "spec_helper"

describe Admin::GuildsController do
  describe "routing" do
    it "routes to #index" do
      get("/fr/admin/guilds").should route_to("admin/guilds#index", :locale => "fr")
    end

    it "routes to #new" do
      get("/fr/admin/guilds/new").should route_to("admin/guilds#new", :locale => "fr")
    end

    it "routes to #show" do
      get("/fr/admin/guilds/42").should route_to("admin/guilds#show", :locale => "fr", :id => "42")
    end

    it "routes to #edit" do
      get("/fr/admin/guilds/42/edit").should route_to("admin/guilds#edit", :locale => "fr", :id => "42")
    end

    it "routes to #create" do
      post("/fr/admin/guilds").should route_to("admin/guilds#create", :locale => "fr")
    end

    it "routes to #update" do
      put("/fr/admin/guilds/42").should route_to("admin/guilds#update", :locale => "fr", :id => "42")
    end

    it "routes to #destroy" do
      delete("/fr/admin/guilds/42").should route_to("admin/guilds#destroy", :locale => "fr", :id => "42")
    end
  end
end
