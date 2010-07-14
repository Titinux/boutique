require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Boutique
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{config.root}/extras )
    config.autoload_paths << "#{config.root}/lib"
    config.autoload_paths << "#{config.root}/app/builders"
    config.autoload_paths << "#{config.root}/app/jobs"
    config.autoload_paths << "#{config.root}/app/sweepers"

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    config.active_record.observers = :order_observer, :log_sweeper

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Paris'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :fr

    # Configure generators values. Many other options are available, be sure to check the documentation.
    #config.generators do |g|
    #  g.orm             :active_record
    #  g.template_engine :erb
     # g.test_framework  :test_unit, :fixture => true
    #end

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end
