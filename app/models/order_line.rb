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

class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :asset

  #validates :order_id, :presence => true

  validates :asset_id, :presence => true
  validates_associated :asset

  validates :quantity, :presence => true, :numericality => { :only_integer => true, :greater_than => 0, :less_than_or_equal_to => 1000000 }
  validates :unitaryPrice, :numericality => { :greater_than_or_equal_to => 0 }, :allow_nil => true

  def total
    quantity * (unitaryPrice || 0)
  end
end
