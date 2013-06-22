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

class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :lines, class_name: 'OrderLine', dependent: :delete_all

  # Attributes
  accepts_nested_attributes_for :lines, allow_destroy: true
  attr_reader(:message)

  # Validations
  validates :user_id, presence: true
  validate :at_least_one_line

  # Callbacks
  after_save :notifications

  state_machine :state, :initial => :quotation do
    event :quote_done do
      transition :quotation => :quote_validation, if: :quote_ready?
    end

    event :quote_accepted do
      transition :quote_validation => :preparation
    end

    event :prepared do
      transition :preparation => :delivery
    end

    event :delivered do
      transition :delivery => :complete
    end

    event :cancel do
      transition any - [:complete, :canceled] => :canceled
    end

    after_transition any => any do |order, transition|
      payload = {
        order_id: order.id,
        event:    transition.event,
        from:     transition.from_name,
        to:       transition.to_name
      }

      ActiveSupport::Notifications.instrument "state_changed.orders.dofus_shop.event", payload
    end
  end

  def quote_ready?
    lines.each do |line|
      return false unless line.unitaryPrice.present?
    end

    true
  end

  def available?
    self.lines.each do |line|
      return false if(Deposit.stock(line.asset) < line.quantity)
    end

    return true
  end

  def total
    lines.to_a.sum(&:total)
  end

  protected

  def at_least_one_line
    if self.lines.size < 1
      errors.add(:base, I18n.t('order.at_least_one_line'))
    end
  end

  def notifications
    ActiveSupport::Notifications.instrument "update.order.dofus_shop", order_id: self.id
  end
end
