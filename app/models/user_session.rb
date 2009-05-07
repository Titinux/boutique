class UserSession
  def initialize(session)
    @session = session
    
    @session[:user] ||= Hash.new
  end
  
  def login?
    @session[:user].fetch('user_id', false)
  end
  
  def autenticate(username, password)
    @user = User.find_by_name(username)
    
    return nil if @user.blank? || !@user.autenticate(password)
      
    @session[:user]['user_id'] = @user.id
    @user
  end
  
  def logout
    @session[:user].delete 'user_id'
    @user = nil
  end
  
  def user
    @user ||= User.find(@session[:user]['user_id'])
  end
end