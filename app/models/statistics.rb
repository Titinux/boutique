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

class Statistics

  def self.stockStats
    assets = Asset.find(:all, :include => [:deposits, :order_lines], :order => :name)

    assets.each do |asset|
      def asset.stock
        @stock ||= self.deposits.validated.sum(:quantity)
      end

      def asset.orderQuantity
        @orderQuantity ||= self.order_lines.inject(0) do |sum, order_line|
          order_line.order.blank? || ['IN_PREPARATION', 'WAIT_DELIVERY'].include?(order_line.order.state) ? (sum + order_line.quantity) : sum
        end
      end
    end
  end

  def self.pigmoneyboxStats
    out = {}

    users = User.all(:order => 'pigMoneyBox DESC')

    out[:sum]     = users.sum(&:pigMoneyBox)
    out[:richests] = users.slice(0, 3)

    out
  end
end
