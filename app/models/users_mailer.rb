class UsersMailer < ActionMailer::Base
  # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
  default :from => 'no-reply@boutique.hyze.bagu.biz'

  def user_account_created(user)
    @user = user

    mail :to => user.email,
         :subject => "Your new account on boutique.hyze.bagu.biz"
  end

  def user_password_reset(user, new_password)
    @user = user
    @new_password = new_password

    mail :to => user.email,
         :subject => "Your account name on boutique.hyze.bagu.biz"
  end
end
