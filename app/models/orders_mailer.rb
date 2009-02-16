class OrdersMailer < ActionMailer::Base
  
  def order_created_admin(order)
    admin_emails = []
    
    User.admins.each {|admin| admin_emails << admin.email }

    bcc admin_emails
    # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
    from "no-reply@boutique.hyze.bagu.biz"
    subject "New order from #{order.user.name}"
    content_type "text/plain"
    body :order => order
  end

  def order_created_user(order)
    recipients order.user.email
    
    # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
    from "no-reply@boutique.hyze.bagu.biz"
    subject "Order ##{order.id} confirmation"
    content_type "text/plain"
    body :order => order
  end

  def order_in_preparation_admin(order)
    admin_emails = []
    
    User.admins.each {|admin| admin_emails << admin.email }

    bcc admin_emails
    # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
    from "no-reply@boutique.hyze.bagu.biz"
    subject "Order ##{order.id} has been accepted"
    content_type "text/plain"
    body :order => order
  end

  def order_in_preparation_user(order)
    recipients order.user.email
    
    # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
    from "no-reply@boutique.hyze.bagu.biz"
    subject "Your Order ##{order.id} is in preparation"
    content_type "text/plain"
    body :order => order
  end

  def order_canceled_admin(order)
    admin_emails = []
    
    User.admins.each {|admin| admin_emails << admin.email }

    bcc admin_emails
    # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
    from "no-reply@boutique.hyze.bagu.biz"
    subject "Order ##{order.id} was canceled"
    content_type "text/plain"
    body :order => order
  end

  def order_canceled_user(order)
    recipients order.user.email
    
    # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
    from "no-reply@boutique.hyze.bagu.biz"
    subject "Order ##{order.id} was canceled"
    content_type "text/plain"
    body :order => order
  end

end
