module OrderTools
  class OrderDispatchException < Exception; end

  def self.available?(order)
    order.orderLines.each do |line|
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

      order.orderLines.each do |orderLine|
        assetQuantity = orderLine.quantity
        deposits = Deposit.find(:all, :conditions => { :asset_id => orderLine.asset.id, :validated => true} , :order => 'quantity DESC')

        deposits.size.downto(1) do |i|
          deposit = deposits[i-1]

          qt = [deposit.quantity, (assetQuantity / i).to_i].min
          money = (qt * orderLine.unitaryPrice * taxe).to_i

          deposit.user.pigMoneyBox += money
          deposit.user.save!

          moneySpent += money
          deposit.quantity_modifier = -qt

          deposit.save!

          assetQuantity -= qt
        end
      end

      raise OrderDispatchException, 'Dispatch money can\'t be superior to order amount !' if moneySpent > order.totalAmount

      tax_collector.pigMoneyBox += order.totalAmount - moneySpent
      tax_collector.save!

      order.dispatched = true
      order.save!
    end
  end
end
