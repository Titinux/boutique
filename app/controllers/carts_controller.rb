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

class CartsController < ApplicationController
  before_filter :authenticate_user!

  # GET /user/cart
  # GET /user/cart.xml
  def index
    respond_with(@carts = current_user.carts.where(:current => false))
  end

  # GET /user/cart/1
  # GET /user/cart/1.xml
  def show
    respond_with(@cart = current_user.carts.find(params[:id]))
  end

  # GET /user/cart/new
  # GET /user/cart/new.xml
  def new
    @cart = current_user.carts.build
    @cart.lines.build

    respond_with(@cart)
  end

  # GET /user/cart/1/edit
  def edit
    @cart = current_user.carts.find(params[:id])

    respond_with(@cart)
  end

  # POST /user/cart
  # POST /user/cart.xml
  def create
    @cart = current_user.carts.build(params[:cart])

    if params[:addline].blank?
      @cart.save
      respond_with(:user, @cart)
    else
      @cart.lines.build
      render :new
    end
  end

  # PUT /user/cart/1
  # PUT /user/cart/1.xml
  def update
    @cart = current_user.carts.find(params[:id])
    @cart.attributes = params[:cart]

    if params[:addline].blank?
      @cart.save
      respond_with(:user, @cart)
    else
      @cart.lines.build
      render :edit
    end
  end

  # DELETE /user/cart/1
  # DELETE /user/cart/1.xml
  def destroy
    @cart = current_user.carts.find(params[:id])
    @cart.destroy

    respond_with(@cart, :location => user_carts_path)
  end

  # GET /user/cart/1/use_it
  # GET /user/cart/1/use_it.xml
  def use_it
    @cart = current_user.carts.find(params[:id])

    if @cart.copy_lines_to(current_user.cart)
      flash[:notice] = t('flash.carts.use_it.notice')
      redirect_to cart_path
    else
      flash[:alert] = t('flash.carts.use_it.alert')
      redirect_to 'show'
    end
  end

  # PUT /user/cart/1/to_order
  # PUT /user/cart/1/to_order.xml
  def to_order
    @cart = current_user.carts.find(params[:id])

    if @cart.to_order
      flash[:notice] = t('flash.carts.to_order.notice')
      redirect_to user_orders_path
    else
      flash[:alert] = t('flash.carts.to_order.alert')
      render 'show'
    end


  end
end
