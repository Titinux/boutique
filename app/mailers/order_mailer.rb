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

class OrderMailer < ActionMailer::Base
  # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
  default :from => 'no-reply@boutique.hyze.fr'

  def order_created_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => t('mailer.order.admin.order_created', :order_id => order.id, :user_name => order.user.name)
  end

  def order_created_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => t('mailer.order.user.order_created', :order_id => order.id)
  end

  def wait_estimate_validation_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => t('mailer.order.user.wait_estimate_validation', :order_id => order.id)
  end

  def order_in_preparation_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => t('mailer.order.admin.order_in_preparation', :order_id => order.id, :user_name => order.user.name)
  end

  def order_in_preparation_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => t('mailer.order.user.order_in_preparation', :order_id => order.id)
  end

  def order_canceled_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => t('mailer.order.admin.order_canceled', :order_id => order.id, :user_name => order.user.name)
  end

  def order_canceled_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => t('mailer.order.user.order_canceled', :order_id => order.id)
  end

  def order_ready_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => t('mailer.order.admin.order_ready', :order_id => order.id, :user_name => order.user.name)
  end

  def order_ready_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => t('mailer.order.user.order_ready', :order_id => order.id)
  end

  def order_achieved_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => t('mailer.order.admin.order_achieved', :order_id => order.id, :user_name => order.user.name)
  end

  def order_achieved_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => t('mailer.order.user.order_achieved', :order_id => order.id)
  end

  private

  def admin_emails
    Administrator.select(:email).map(&:email)
  end

end
