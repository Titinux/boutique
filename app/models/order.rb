class Order < ActiveRecord::Base
  belongs_to :user
  
  has_many :orderLines, :dependent => :delete_all
  
  # Scopes
  named_scope :ongoing, :conditions => ["state IN ('WAIT_ESTIMATE', 'WAIT_ESTIMATE_VALIDATION', 'IN_PREPARATION', 'WAIT_DELIVERY')"]
  default_scope  :order => 'id DESC'
  
  # Callbacks
  after_update :save_lines
  
  attr_reader(:message)
  
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
      when 'CANCEL_ORDER'
        if self.state == 'WAIT_ESTIMATE'
          self.state = 'ORDER_CANCELED'
          
          if self.save
            @message = I18n.t('order.cancelSucces')
          else  
            @message = I18n.t('order.cancelFail')
            return false
          end
        end
      
      when 'MAKE_ESTIMATE'
        if self.state == 'WAIT_ESTIMATE'
          self.state = 'WAIT_ESTIMATE_VALIDATION'
        
          if self.save
            @message = I18n.t('order.estimate.created')
          else
            @message = I18n.t('order.modifyFail')
            return false
          end
        end
      
      when 'ACCEPT_ESTIMATE'
        if self.state == 'WAIT_ESTIMATE_VALIDATION'
          self.state = 'IN_PREPARATION'
          
          if self.save
            @message = I18n.t('order.estimate.accepted')
          else
            @message = I18n.t('order.modifyFail')
            return false
          end
        end
      
      when 'REFUSE_ESTIMATE'
        if self.state == 'WAIT_ESTIMATE_VALIDATION'
          self.state = 'ORDER_CANCELED'
          
          if self.save
            @message = I18n.t('order.estimate.canceled')
          else
            @message = I18n.t('order.modifyFail')
            return false
          end
        end       
      else
        @message = 'Error !'
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
      return false if(Deposite.stock(orderLine.asset) < orderLine.quantity)
    end
    
    return true
  end
  
  
end
