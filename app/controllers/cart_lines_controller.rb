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

class CartLinesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @cart_line = NewCartLine.new(:user => current_user, :cart_id => current_user.cart.id, :asset_id => params[:asset_id])

    respond_with(@cart_line)
  end

  def edit
    cart = current_user.carts.find(params[:cart_id])

    respond_with(@cart_line = cart.lines.find(params[:id]))
  end

  def create
    @cart_line = NewCartLine.new(new_cart_line_params.merge(:user => current_user))

    if @cart_line.save
      flash[:notice] = t('flash.cart_lines.create.notice',
                         count: @cart_line.quantity.to_i,
                         asset: @cart_line.asset.name,
                         cart:  @cart_line.cart.name)

      @cart_line.cart.touch
    end

    respond_with(@cart_line, :location => category_path(@cart_line.asset.category))
  end

  def update
    cart = current_user.carts.find(params[:cart_id])
    @cart_line = cart.lines.find(params[:id])
    @cart_line.update_attributes(cart_line_params)

    respond_with(@cart_line, :location => cart_path(cart))
  end

  def destroy
    cart = current_user.carts.find(params[:cart_id])
    @cart_line = cart.lines.find(params[:id])
    @cart_line.destroy

    respond_with(@cart_line, :location => cart_path(cart))
  end

  private

  def new_cart_line_params
    params.require(:new_cart_line).permit(:asset_id, :cart_id, :cart_name, :quantity)
  end

  def cart_line_params
    params.require(:cart_line).permit(:quantity)
  end
end
