module OrderTools
  class OrderDispatchException < Exception; end

  def self.available?(order)
    order.orderLines.each do |line|
      return false if(Deposit.stock(line.asset) < line.quantity)
    end

    return true
  end

  def self.dispatch(order)
    raise OrderDispatchException, 'This order have already been dispatched !' if order.dispatched
    raise OrderDispatchException, 'Stocks are insufficient to dispatch this order !' unless available?(order)

    # TODO : Utliser une option pour définir un compte qui récupère l'argent "en trop".
    tax_collector = User.find_by_name('Marchands d\'Hyze')

    order.transaction do

      moneySpent = 0
      # TODO : Utiliser une option pour gérer le montant de la taxe.
      taxe = (100 - 1.to_f) / 100

      order.orderLines.each do |orderLine|
        assetQuantity = orderLine.quantity
        deposites = Deposit.find(:all, :conditions => { :asset_id => orderLine.asset.id, :validated => true} , :order => 'quantity DESC')

        deposites.size.downto(1) do |i|
          deposite = deposites[i-1]
          qt = [deposite.quantity, (assetQuantity / i).to_i].min
          money = (qt * orderLine.unitaryPrice * taxe).to_i

          deposite.user.pigMoneyBox += money
          deposite.user.save

          moneySpent += money
          deposite.quantity -= qt

          if deposite.quantity == 0
            deposite.destroy
          else
            deposite.save
          end

          assetQuantity -= qt
        end
      end

      if moneySpent < order.totalAmount
        tax_collector.pigMoneyBox += order.totalAmount - moneySpent
        tax_collector.save
      end

      order.dispatched = true
      order.save
    end
  end
end
