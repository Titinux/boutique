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

class Order < ActiveRecord::Base
  belongs_to :user
  has_many :lines, :class_name => 'OrderLine', :dependent => :delete_all

  # Attributes
  accepts_nested_attributes_for :lines, :allow_destroy => true
  attr_searchable  :id, :state
  assoc_searchable :user
  attr_reader(:message)

  # Validations
  validates :user_id, :presence => true
  validates_associated :user

  validates :state,   :presence => true
  validates :lines,   :presence => true

  validates_associated :lines

  def modifyState(op)
    case op
      when 'CANCEL_ORDER'
        if self.state == 'WAIT_ESTIMATE'
          self.state = 'ORDER_CANCELED'

          if self.save
            @message = I18n.t('order.cancelSucces')
          else
            @message = I18n.t('order.cancelFail')
            return false
          end
        end

      when 'MAKE_ESTIMATE'
        if self.state == 'WAIT_ESTIMATE'
          self.state = 'WAIT_ESTIMATE_VALIDATION'

          if self.save
            @message = I18n.t('order.estimate.created')
          else
            @message = I18n.t('order.modifyFail')
            return false
          end
        end

      when 'ACCEPT_ESTIMATE'
        if self.state == 'WAIT_ESTIMATE_VALIDATION'
          self.state = 'IN_PREPARATION'

          if self.save
            @message = I18n.t('order.estimate.accepted')
          else
            @message = I18n.t('order.modifyFail')
            return false
          end
        end

      when 'REFUSE_ESTIMATE'
        if self.state == 'WAIT_ESTIMATE_VALIDATION'
          self.state = 'ORDER_CANCELED'

          if self.save
            @message = I18n.t('order.estimate.canceled')
          else
            @message = I18n.t('order.modifyFail')
            return false
          end
        end
      else
        @message = 'Error !'
      end

    true
  end

  def totalAmount
    amount = 0.0

    lines.each do |line|
      amount += line.quantity * (line.unitaryPrice || 0)
    end

    amount
  end

  def available?
    self.lines.each do |line|
      return false if(Deposit.stock(line.asset) < line.quantity)
    end

    return true
  end


end
