class OrderObserver < ActiveRecord::Observer 
  
  def after_create(order)
    OrdersMailer.deliver_order_created_admin(order)
    OrdersMailer.deliver_order_created_user(order)
  end

  def after_update(order)
    if order.state_changed?
      case order.state
        when 'WAIT_ESTIMATE_VALIDATION'
          OrdersMailer.deliver_wait_estimate_validation_user(order)
          
        when 'IN_PREPARATION'
          OrdersMailer.deliver_order_in_preparation_admin(order)
          OrdersMailer.deliver_order_in_preparation_user(order)
        
        when 'ORDER_CANCELED'
          OrdersMailer.deliver_order_canceled_admin(order)
          OrdersMailer.deliver_order_canceled_user(order)
 
        when 'WAIT_DELIVERY'
          OrdersMailer.deliver_order_ready_admin(order)
          OrdersMailer.deliver_order_ready_user(order)
 
        when 'ACHIEVED'
          OrdersMailer.deliver_order_achieved_admin(order)
          OrdersMailer.deliver_order_achieved_user(order)
          
          Delayed::Job.enqueue DispatchOrderJob.new(order.id)
      end
    end
  end
end
