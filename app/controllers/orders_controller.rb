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

class OrdersController < ApplicationController
  before_filter :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do
    flash[:alert] = 'Order not found !'
    redirect_to user_path
  end

  def index
    respond_with(@orders = current_user.orders)
  end

  def show
    respond_with(@order = current_user.orders.find(params[:id]))
  end

  def new
    @cart = current_user.carts.find(params[:cart_id])
    @order = @cart.to_order

    respond_with(@order)
  end

  def create
    @cart = current_user.carts.find(params[:order][:cart][:id])
    @order = @cart.to_order
    @order.comment = params[:order][:comment]

    if @order.save
      @cart.destroy if params[:order][:cart][:remove_after_ordered] == '1'
    end

    respond_with(@order, :location => user_orders_path)
  end

  def update
    @order = current_user.orders.find(params[:id])

    if @order.modifyState(params[:op])
      flash[:notice] = @order.message
    else
      flash[:alert] = @order.message
    end

    respond_with(@order, :location => user_path)
  end
end
