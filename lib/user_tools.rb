module UserTools
  def self.passwordReset(user)
    newPass = Crypt::makeRandomSequence(8)
    user.password = newPass
    user.save
    UsersMailer.user_password_reset(user, newPass).deliver
  end
end
