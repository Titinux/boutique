class OrdersMailer < ActionMailer::Base
  # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
  default :from => 'no-reply@boutique.hyze.bagu.biz'

  def order_created_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => "New order from #{order.user.name}"
  end

  def order_created_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => "Order ##{order.id} confirmation"
  end

  def wait_estimate_validation_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => "Your order ##{order.id} has been estimated"
  end

  def order_in_preparation_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => "Order ##{order.id} has been accepted"
  end

  def order_in_preparation_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => "Your Order ##{order.id} is in preparation"
  end

  def order_canceled_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => "Order ##{order.id} was canceled"
  end

  def order_canceled_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => "Order ##{order.id} was canceled"
  end

  def order_ready_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => "Order ##{order.id} is ready"
  end

  def order_ready_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => "Your order ##{order.id} is ready"
  end

  def order_achieved_admin(order)
    @order = order

    mail :bcc => admin_emails,
         :subject => "Order ##{order.id} is finished"
  end

  def order_achieved_user(order)
    @order = order

    mail :to => order.user.email,
         :subject => "Your order ##{order.id} is now achieved"
  end

  private

  def admin_emails
    Administrator.select(:email).map(&:email)
  end

end
