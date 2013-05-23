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

module OrderTools
  class OrderDispatchException < Exception; end

  def self.available?(order)
    order.lines.each do |line|
      return false if(Deposit.stock(line.asset) < line.quantity)
    end

    return true
  end

  def self.dispatch(order)
    raise OrderDispatchException, 'This order has already been dispatched !' if order.dispatched
    raise OrderDispatchException, 'Stocks are insufficient to dispatch this order !' unless available?(order)

    # TODO : Utliser une option pour définir un compte qui récupère l'argent "en trop".
    tax_collector = User.find_by_name('Marchands d\'Hyze')
    raise OrderDispatchException, 'Tax collector can\'t be found !' if tax_collector.blank?

    Order.transaction do

      moneySpent = 0
      # TODO : Utiliser une option pour gérer le montant de la taxe.
      taxe = (100 - 1.to_f) / 100

      order.lines.each do |line|
        assetQuantity = line.quantity
        deposits = Deposit.find(:all, :conditions => { :asset_id => line.asset.id, :validated => true} , :order => 'quantity DESC')

        deposits.size.downto(1) do |i|
          deposit = deposits[i-1]

          qt = [deposit.quantity, (assetQuantity / i).to_i].min
          money = (qt * line.unitaryPrice * taxe).to_i

          deposit.user.pigMoneyBox += money
          deposit.user.save!

          moneySpent += money
          deposit.quantity_modifier = -qt

          deposit.save!

          assetQuantity -= qt
        end
      end

      raise OrderDispatchException, 'Dispatch money can\'t be superior to order amount !' if moneySpent > order.totalAmount

      # Reloding tax collector object because pigMoneybox value is outdated if this account can have sell assets.
      tax_collector.reload
      tax_collector.pigMoneyBox += order.totalAmount - moneySpent
      tax_collector.save!

      order.dispatched = true
      order.save!
    end
  end
end
