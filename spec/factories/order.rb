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

Factory.define :order do |o|
  o.association :user, :factory => :user
  o.state 'WAIT_ESTIMATE'

  o.lines {|l| [Factory.build(:order_line)]}
end

Factory.define :estimated_order, :parent => :order do |o|
  o.state 'WAIT_ESTIMATE_VALIDATION'
  o.lines do |l|
    [
      Factory.build(:estimated_order_line),
      Factory.build(:estimated_order_line)
    ]
  end
end

Factory.define :in_preparation_order, :parent => :estimated_order do |o|
  o.state 'IN_PREPARATION'
end

Factory.define :canceled_order, :parent => :estimated_order do |o|
  o.state 'ORDER_CANCELED'
end

Factory.define :ready_order, :parent => :estimated_order do |o|
  o.state 'WAIT_DELIVERY'
end

Factory.define :achieved_order, :parent => :estimated_order do |o|
  o.state 'ACHIEVED'
end
