require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :xml

  layout 'public'

  protect_from_forgery

  before_filter :set_locale

  helper_method :cart_session
#
#  #cache_sweeper :log_sweeper
#

  def default_url_options(options={})
    {:locale => I18n.locale}
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def cart_session
    @cart_session_cache ||= Cart.new(session)
  end
end
