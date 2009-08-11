class UsersMailer < ActionMailer::Base
  def user_account_created(user)
    recipients user.email
    
    # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
    from "no-reply@boutique.hyze.bagu.biz"
    subject "Your new account on boutique.hyze.bagu.biz"
    content_type "text/plain"
    body :user => user
  end
  
  def user_password_reset(user, new_password)
    recipients user.email
    
    # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
    from "no-reply@boutique.hyze.bagu.biz"
    subject "Your account name on boutique.hyze.bagu.biz"
    content_type "text/plain"
    body :user => user, :new_password => new_password
  end
end
