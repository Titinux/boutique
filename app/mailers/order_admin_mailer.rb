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

class OrderAdminMailer < ActionMailer::Base
  # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
  default from: 'no-reply@boutique.hyze.fr'

  def created(order_id, recipient)
    @order = Order.find(order_id)

    mail to: recipient,
         subject: t('mailer.order.admin.order_created', order_id: @order.id, user_name: @order.user.name)
  end

  def preparation(order_id, recipient)
    @order = Order.find(order_id)

    mail to: recipient,
         subject: t('mailer.order.admin.order_in_preparation', order_id: @order.id, user_name: @order.user.name)
  end

  def delivery(order_id, recipient)
    @order = Order.find(order_id)

    mail to: recipient,
         subject: t('mailer.order.admin.order_ready', order_id: @order.id, user_name: @order.user.name)
  end

  def complete(order_id, recipient)
    @order = Order.find(order_id)

    mail to: recipient,
         subject: t('mailer.order.admin.order_achieved', order_id: @order.id, user_name: @order.user.name)
  end

  def cancel(order_id, recipient)
    @order = Order.find(order_id)

    mail to: recipient,
         subject: t('mailer.order.admin.order_canceled', order_id: @order.id, user_name: @order.user.name)
  end
end
