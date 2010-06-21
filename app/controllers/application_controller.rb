require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :xml

  layout 'public'

  protect_from_forgery

  before_filter :set_locale

  helper_method :cart_session
  helper_method :user_session
#
#  #cache_sweeper :log_sweeper
#

  def default_url_options(options={})
    {:locale => I18n.locale}
  end

  private

  def set_locale
    I18n.locale = params[:locale]
  end

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
