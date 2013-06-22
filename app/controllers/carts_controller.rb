# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2013 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
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

class CartsController < ApplicationController
  before_filter :authenticate_user!

  def show
    if params[:id] == 'current'
      @cart = current_user.cart
    else
      @cart = current_user.carts.find(params[:id])
    end

    respond_with(@cart)
  end

  def edit
    @cart = current_user.carts.find(params[:id])

    respond_with(@cart)
  end

  def update
    @cart = current_user.carts.find(params[:id])
    @cart.update_attributes(cart_params)

    respond_with(@cart, location: cart_path(id: 'current'))
  end

  def destroy
    @cart = current_user.carts.find(params[:id])
    @cart.destroy

    respond_with(@cart, location: cart_path(id: 'current'))
  end

  private

  def cart_params
    params.require(:cart).permit(:name)
  end
end
