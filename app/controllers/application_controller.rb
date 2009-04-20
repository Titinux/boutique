# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  helper_method :cart_session
  helper_method :user_session

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery #:secret => '844413bf90e37d2f78c0ec39219eb135'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  private
  
  def cart_session
    @cart_session_cache ||= Cart.new(session)
  end
  
  def user_session
    @user_session_cache ||= UserSession.new(session)
  end
end