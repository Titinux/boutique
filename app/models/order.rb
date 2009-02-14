class Order < ActiveRecord::Base
  belongs_to :user
  
  has_many :orderLines
  
  named_scope :ongoing, :conditions => ["state < 4"]
  
  # Callbacks
  after_update :save_lines
  
  def new_line_attributes=(line_attributes)
    line_attributes.each do |attributes|
      orderLines.build(attributes)
    end
  end
  
  def existing_line_attributes=(line_attributes)
    orderLines.reject(&:new_record?).each do |line|
      attributes = line_attributes[line.id.to_s]

      if attributes
        line.attributes = attributes
      else
        orderLines.delete(line)
      end
    end
  end
  
  def save_lines
    orderLines.each do |line|
      line.save(false)
    end
  end
  
  def modifyState(op)
    case op
      when 'ACCEPT_ESTIMATE'
        if self.state == 'WAIT_ESTIMATE_VALIDATION'
          self.state = 'IN_PREPARATION'
        else
          return false
        end
      
      when 'REFUSE_ESTIMATE'
        if self.state == 'WAIT_ESTIMATE_VALIDATION'
          self.state = 'ORDER_CANCELED'
        else
          return false
        end    
    end
    
    true
  end
  
  def totalAmount
    amount = 0
    
    orderLines.each do |orderLine| 
      amount += orderLine.quantity * orderLine.unitaryPrice
    end
    
    amount
  end
  
  def available?
    self.orderLines.each do |orderLine|
      if(Deposite.stock(orderLine.asset) < orderLine.quantity)
        return false
      end
    end
    
    return true
  end
  
  def dispatchMoney
    self.transaction do
    
      dispatchedMoney = 0
      # TODO : Utiliser une option pour gérer le montant de la taxe. 
      taxe = (100 - 5) / 100 
      
      self.orderLines.each do |orderLine|
        assetQuantity = orderLine.quantity
        deposites = Array Deposite.find_all_by_asset_id(orderLine.asset.id, :order => 'quantity DESC')
        
        deposites.size.downto(1) do |i|
          deposite = deposites[i-1]
          qt = [deposite.quantity, (assetQuantity / i).to_i].min
          money = (qt * orderLine.unitaryPrice * taxe).to_i
          
          deposite.user.pigMoneyBox += money
          deposite.user.save
          
          dispatchedMoney += money
          
          if qt == deposite.quantity
            deposite.delete
          else
            deposite.quantity -= qt
          end
          
          deposite.save
          
          assetQuantity -= qt
        end
      end
      
      if dispatchedMoney < totalAmount
          # TODO : Utliser une option pour définir un compte qui récupère l'argent "en trop".
          #User.find(???).pigMoneyBox += totalAmount - dispatchedMoney
      end
      
    end
  end
end
