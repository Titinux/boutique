class ApplicationController < ActionController::Base
  protect_from_forgery

  self.responder = ApplicationResponder
  respond_to :html, :xml

  layout 'public'

  before_filter :set_locale_from_url

  helper_method :cart_session
#
#  #cache_sweeper :log_sweeper
#

  def set_locale_from_url
    I18n.locale = params[:locale] if params[:locale]
  end

  def self.default_url_options(options={})
    options.merge({ :locale => I18n.locale })
  end

  def cart_session
    @cart_session_cache ||= Cart.new(session)
  end
end
