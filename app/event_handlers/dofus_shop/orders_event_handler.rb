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

module DofusShop
  class OrdersEventHandler
    def self.state_changed(payload)
      payload.symbolize_keys!

      case payload[:event]
        when 'quote_done'     then quote_done(payload[:order_id])
        when 'quote_accepted' then quote_accepted(payload[:order_id])
        when 'prepared'       then prepared(payload[:order_id])
        when 'delivered'      then delivered(payload[:order_id])
        when 'canceled'       then canceled(payload[:order_id])
      end
    end

    private

    def self.quote_done(order_id)
      OrderCustomerMailer.delay.quote_validation(order_id)
    end

    def self.quote_accepted(order_id)
      OrderCustomerMailer.delay.preparation(order_id)

      admin_emails.each do |address|
        OrderAdminMailer.delay.preparation(order_id, address)
      end
    end

    def self.prepared(order_id)
      OrderCustomerMailer.delay.delivery(order_id)

      admin_emails.each do |address|
        OrderAdminMailer.delay.delivery(order_id, address)
      end
    end

    def self.delivered(order_id)
      OrderCustomerMailer.delay.complete(order_id)
      DispatchWorker.perform_async(order_id)

      admin_emails.each do |address|
        OrderAdminMailer.delay.complete(order_id, address)
      end
    end

    def self.canceled(order_id)
      OrderCustomerMailer.delay.cancel(order_id)

      admin_emails.each do |address|
        OrderAdminMailer.delay.cancel(order_id, address)
      end
    end

    private

    def self.admin_emails
      Administrator.select(:email).map(&:email)
    end
  end
end

