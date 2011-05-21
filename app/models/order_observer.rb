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

class OrderObserver < ActiveRecord::Observer

  def after_create(order)
    OrdersMailer.order_created_admin(order).deliver
    OrdersMailer.order_created_user(order).deliver
  end

  def after_update(order)
    if order.state_changed?
      case order.state
        when 'WAIT_ESTIMATE_VALIDATION'
          OrdersMailer.wait_estimate_validation_user(order).deliver

        when 'IN_PREPARATION'
          OrdersMailer.order_in_preparation_admin(order).deliver
          OrdersMailer.order_in_preparation_user(order).deliver

        when 'ORDER_CANCELED'
          OrdersMailer.order_canceled_admin(order).deliver
          OrdersMailer.order_canceled_user(order).deliver

        when 'WAIT_DELIVERY'
          OrdersMailer.order_ready_admin(order).deliver
          OrdersMailer.order_ready_user(order).deliver

        when 'ACHIEVED'
          OrdersMailer.order_achieved_admin(order).deliver
          OrdersMailer.order_achieved_user(order).deliver

          Delayed::Job.enqueue DispatchOrderJob.new(order.id)
      end
    end
  end
end
