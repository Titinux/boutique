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

FactoryGirl.define do
  factory :order do
    association :user, :factory => :user
    state 'WAIT_ESTIMATE'

    lines {|l| [FactoryGirl.build(:order_line)]}
  end

  factory :estimated_order, :parent => :order do
    state 'WAIT_ESTIMATE_VALIDATION'
    lines do |l|
      [
        FactoryGirl.build(:estimated_order_line),
        FactoryGirl.build(:estimated_order_line)
      ]
    end
  end

  factory :in_preparation_order, :parent => :estimated_order do
    state 'IN_PREPARATION'
  end

  factory :canceled_order, :parent => :estimated_order do
    state 'ORDER_CANCELED'
  end

  factory :ready_order, :parent => :estimated_order do
    state 'WAIT_DELIVERY'
  end

  factory :achieved_order, :parent => :estimated_order do
    state 'ACHIEVED'
  end
end
