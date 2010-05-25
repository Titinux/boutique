class OrderObserver < ActiveRecord::Observer

  def after_create(order)
    OrdersMailer.order_created_admin(order).deliver
    OrdersMailer.order_created_user(order).deliver
  end

  def after_update(order)
    if order.state_changed?
      case order.state
        when 'WAIT_ESTIMATE_VALIDATION'
          OrdersMailer.wait_estimate_validation_user(order).deliver

        when 'IN_PREPARATION'
          OrdersMailer.order_in_preparation_admin(order).deliver
          OrdersMailer.order_in_preparation_user(order).deliver

        when 'ORDER_CANCELED'
          OrdersMailer.order_canceled_admin(order).deliver
          OrdersMailer.order_canceled_user(order).deliver

        when 'WAIT_DELIVERY'
          OrdersMailer.order_ready_admin(order).deliver
          OrdersMailer.order_ready_user(order).deliver

        when 'ACHIEVED'
          OrdersMailer.order_achieved_admin(order).deliver
          OrdersMailer.order_achieved_user(order).deliver

          Delayed::Job.enqueue DispatchOrderJob.new(order.id)
      end
    end
  end
end
