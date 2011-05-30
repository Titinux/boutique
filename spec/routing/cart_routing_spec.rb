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

describe CartController do
  describe "routing" do

    it "routes to #show" do
      { :get => "/fr/cart" }.should route_to("cart#show", :locale => "fr")
    end

    it "routes to #edit" do
      { :get => "/fr/cart/edit" }.should route_to("cart#edit", :locale => "fr")
    end

    it "routes to #update" do
      { :put => "/fr/cart" }.should route_to("cart#update", :locale => "fr")
    end

    it "routes to #destroy" do
      { :delete => "/fr/cart" }.should route_to("cart#destroy", :locale => "fr")
    end

    it "routes to #save" do
      { :get => "/fr/cart/save" }.should route_to("cart#save", :locale => "fr")
    end

    it "routes to #to_order" do
      { :get => "/fr/cart/to_order" }.should route_to("cart#to_order", :locale => "fr")
    end
  end
end
