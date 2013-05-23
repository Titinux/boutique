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

module Admin::OrdersHelper
  def orderStatusHash
    Hash['WAIT_ESTIMATE',            I18n.t('order.state.waitEstimate'),
         'WAIT_ESTIMATE_VALIDATION', I18n.t('order.state.waitEstimateValidation'),
         'IN_PREPARATION',           I18n.t('order.state.preparation'),
         'WAIT_DELIVERY',            I18n.t('order.state.waitDelivery'),
         'ACHIEVED',                 I18n.t('order.state.achieved'),
         'ORDER_CANCELED',           I18n.t('order.state.canceled'),
         'ERROR',                    I18n.t('order.state.error')
        ]
  end

  def orderActionHash
    Hash['CREATE_ESTIMATE', I18n.t('order.action.create'),
         'ACCEPT_ESTIMATE', I18n.t('order.action.accept'),
         'REFUSE_ESTIMATE', I18n.t('order.action.refuse'),
         'ORDER_PREPARED',  I18n.t('order.action.prepared'),
         'ORDER_DELIVERED', I18n.t('order.action.delivered')
        ]
  end
end
