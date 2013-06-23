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

module Admin
  class OrdersController < AdminController
    def index
      search_params = { "s" => "id desc",
                        "state_in" => %W(quotation quote_validation preparation delivery)
                      }.merge(params[:q] || {})

      @q = Order.includes(:lines, :user).search(search_params)
      @orders = @q.result.page(params[:page])

      respond_with(@orders)
    end

    def show
      respond_with(@order = Order.find(params[:id]))
    end

    def new
      @order = Order.new

      respond_with(@order)
    end

    def edit
      respond_with(@order = Order.find(params[:id]))
      #@estimateRestriction = params[:estimate]
    end

    def quote
      respond_with(@order = Order.find(params[:id]))
    end

    def create
      @order = Order.new(order_params)
      @order.save

      respond_with(:admin, @order)
    end

    def update
      @order = Order.find(params[:id])
      @order.update_attributes(order_params)

      respond_with(:admin, @order)
    end

    def quote_done
      @order = Order.find(params[:id])

      if @order.update_attributes(quote_params)
        if @order.state_events.include?(:quote_done) && @order.quote_ready?
          @order.quote_done
        end
      end

      respond_with(:admin, @order)
    end

    def event
      @order = Order.find(params[:id])
      @order.send params[:event]

      redirect_to action: :show
    end

    def destroy
      @order = Order.find(params[:id])
      @order.destroy

      respond_with(:admin, @order)
    end

    private

      def quote_params
        params.require(:order).permit(lines_attributes: [:id, :unitaryPrice])
      end

      def order_params
        params.require(:order).permit(:user_id, :state, :comment,
                                      lines_attributes: [:id, :asset_id, :quantity, :unitaryPrice, :_destroy])
      end
  end
end
