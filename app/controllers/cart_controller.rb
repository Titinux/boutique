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

class CartController < ApplicationController
  before_filter :authenticate_user!

  # GET /cart
  # GET /cart.xml
  def show
    respond_with(@cart = current_user.cart)
  end

  def edit
    @cart = current_user.cart

    respond_with(@cart, :location => cart_path)
  end

  def update
    @cart = current_user.cart
    @cart.attributes = params[:cart]

    if params[:addline].blank?
      @cart.save
      respond_with(@cart, :location => cart_path)
    else
      @cart.lines.build
      render :edit
    end
  end

  # DELETE /cart/
  # DELETE /cart.xml
  def destroy
    @cart = current_user.cart
    @cart.destroy

    respond_with(@cart, :location => cart_path)
  end

  # GET /cart/save
  # GET /cart/save.xml
  def save
    @cart = current_user.carts.build

    current_user.cart.lines.each do |line|
      @cart.lines.build(line.attributes)
    end
  end

  # PUT /cart/to_order
  # PUT /cart/to_order
  def to_order
    @cart = current_user.cart

    if @cart.to_order
      flash[:notice] = t('flash.carts.to_order.notice')
      @cart.lines.delete_all
      redirect_to user_orders_path
    else
      flash[:alert] = t('flash.carts.to_order.alert')
      render 'show'
    end
  end
end
