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

class Deposit < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :asset

  # Attributes
  attr_accessor :quantity_modifier
  attr_accessible :user_id, :asset_id, :validated, :quantity_modifier
  attr_searchable
  assoc_searchable :user, :asset

  # Validations
  validates_presence_of :user_id, :asset_id

  validates :quantity, :numericality => { :only_integer => true }
  validates :quantity_modifier, :numericality => { :only_integer => true }

  validate :not_duplicate
  validate :coherant_quantity

  # Callbacks
  after_initialize :set_default_values
  before_save :compute_quantity
  after_save :delete_me_if_empty

  # Scopes
  def self.deposits_of(asset)
    where(:asset_id => asset.to_param)
  end

  def self.validated( op = true)
    where(:validated => op)
  end

  # Approve a deposit
  def approve
    # Find a validated duplicate.
    stock = Deposit.find_or_new({:user_id => user_id, :asset_id => asset_id, :validated => true})

    stock.quantity_modifier = self.quantity

    stock.save && self.destroy
  end

  # Class method to get the total amount of an asset
  def self.stock(asset)
    validated.deposits_of(asset).sum(:quantity)
  end

  def self.find_or_new(params)
    Deposit.where(params).first || Deposit.new(params)
  end

  private

  # Default values
  def set_default_values
    self[:quantity] ||= 0
    self.quantity_modifier ||= 0
  end


  # Validation
  def not_duplicate
    unless Deposit.where({ :user_id => self.user_id, :asset_id => self.asset_id, :validated => self.validated }).reject {|d| d.id == self.id }.blank?
      errors.add :base, I18n.t('deposit.validation.duplicate_is_forbidden')
    end
  end

  # Validation
  def coherant_quantity
    final_quantity = self.quantity.to_i + self.quantity_modifier.to_i
    potential_user_stock = Deposit.where({ :user_id => self.user_id, :asset_id => self.asset_id }).sum(:quantity)

    if self.validated?
      errors.add :base, I18n.t('deposit.validation.stock_cant_be_negative') if final_quantity < 0
    else
      errors.add :base, I18n.t('deposit.validation.withdrawal_cant_be_superior_to_deposits') if self.quantity_modifier.to_i + potential_user_stock < 0
    end
  end

  # Before save
  def compute_quantity
    self.quantity += self.quantity_modifier.to_i if self.valid?
  end

  # After save
  def delete_me_if_empty
    if self.quantity == 0
      self.destroy
    end
  end

end
