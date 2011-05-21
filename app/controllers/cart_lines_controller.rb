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

class CartLinesController < ApplicationController
  # GET /cart/new
  # GET /cart/new.xml
  def new
    respond_with(@cart_line = current_user.cart.lines.build(:asset_id => params[:asset_id]))
  end

  # GET /cart/1/edit
  def edit
    respond_with(@cart_line = current_user.cart.lines.find(params[:id]))
  end

  # POST /cart
  # POST /cart.xml
  def create
    @cart_line = current_user.cart.lines.build(params[:cart_line])
    @cart_line.save

    if params[:submit_and_view_cart].blank?
      location = category_path(@cart_line.asset.category)
    else
      location = cart_path
    end

    respond_with(@cart_line, :location => location)
  end

  # PUT /cart/1
  # PUT /cart/1.xml
  def update
    @cart_line = current_user.cart.lines.find(params[:id])
    @cart_line.update_attributes(params[:cart_line])

    respond_with(@cart_line, :location => cart_path)
  end

  # DELETE /cart/1
  # DELETE /cart/1.xml
  def destroy
    @cart = current_user.cart.lines.find(params[:id])
    @cart.destroy

    respond_with(@cart, :location => cart_path)
  end
end
