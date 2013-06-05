require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'rack/contrib'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

# Load config file
CONFIG = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
CONFIG.merge! CONFIG.fetch(Rails.env, {})
CONFIG.symbolize_keys!

module Boutique
  VERSION = "1.3.0.alpha".freeze

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths << "#{config.root}/lib"

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Paris'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :fr]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    config.active_record.observers = :order_observer, :log_sweeper

    # Schema is dump in sql format
    config.active_record.schema_format = :sql

    # Configure generators values. Many other options are available, be sure to check the documentation.
    config.generators do |g|
      g.orm                 :active_record
      g.template_engine     :haml
      g.test_framework      :rspec, :fixture => true
      g.stylesheets         false
      g.stylesheet_engine   :sass
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    # Add middlewares
    config.middleware.use Rack::Locale

    # Mailer config
    CONFIG[:action_mailer].each_pair do |key, value|
      config.action_mailer.send("#{key}=".to_sym, value)
    end
  end
end
