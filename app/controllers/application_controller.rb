class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :cart_session
  helper_method :user_session
#
#  #cache_sweeper :log_sweeper
#
  private

  def cart_session
    @cart_session_cache ||= Cart.new(session)
  end

  def user_session
    @user_session_cache ||= UserSession.new(session)
  end

  def authentication
    unless user_session.login?
      flash[:error] = t('userSession.youHaveToLog')
      session[:urlRequested] = request.url
      redirect_to login_path
      false
    end
  end
end
#
#ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
#  if html_tag =~ /<label/
#    html_tag
#  else
#    "<span class=\"fieldWithErrors\">#{html_tag}</span>"
#  end
#end
