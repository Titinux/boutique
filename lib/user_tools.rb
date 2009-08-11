module UserTools
  def self.passwordReset(user)
    newPass = Crypt::makeRandomSequence(8)
    user.password = newPass
    user.save
    UsersMailer.deliver_user_password_reset(user, newPass)
  end
end
