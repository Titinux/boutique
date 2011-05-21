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

class Admin::OrdersController < Admin::AdminController
  # GET /admin/orders
  # GET /admin/orders.xml
  def index
    if params[:search].blank?
      params[:search] = ActiveSupport::HashWithIndifferentAccess.new(:state_in => %W(WAIT_ESTIMATE WAIT_ESTIMATE_VALIDATION IN_PREPARATION WAIT_DELIVERY))
    end

    @search = Order.search(params[:search])
    @orders = @search.relation

    @orders = @orders.includes(:lines).page(params[:page]).order(:state)

    respond_with(@orders)
  end

  # GET /admin/orders/1
  # GET /admin/orders/1.xml
  def show
    respond_with(@order = Order.find(params[:id]))
  end

  # GET /admin/orders/new
  # GET /admin/orders/new.xml
  def new
    @order = Order.new
    @order.lines.build

    respond_with(@order)
  end

  # GET /admin/orders/1/edit
  def edit
    respond_with(@order = Order.find(params[:id]))
    #@estimateRestriction = params[:estimate]
  end

  # POST /admin/orders
  # POST /admin/orders.xml
  def create
    @order = Order.new(params[:order])
    @order.save

    respond_with(:admin, @order)
  end

  # PUT /admin/orders/1
  # PUT /admin/orders/1.xml
  def update
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])

    respond_with(:admin, @order)
  end

  # DELETE /admin/orders/1
  # DELETE /admin/orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_with(:admin, @order)
  end
end
