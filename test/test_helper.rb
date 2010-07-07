ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def user_session
    UserSession.new(session)
  end

  def autenticate_as_admin
    user_session.autenticate('Boule', 'boule')
  end

  def autenticate_as_gatherer
    user_session.autenticate('Toto', 'toto')
  end

  def autenticate_as_simple_user
    user_session.autenticate('Pim', 'pim')
  end

  def autenticate(username, password)
    user_session.autenticate(username, password)
  end

  def logout
    user_session.logout
  end

  def admin_section_forbidden
    assert flash[:alert].include?("You're not allowed to browse admin section")
    assert_redirected_to root_path
  end

  def unautenticated_forbidden
    assert flash[:alert].include?(I18n.t('userSession.youHaveToLog'))
    assert_redirected_to login_path
  end
end
