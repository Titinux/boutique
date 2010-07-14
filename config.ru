# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'rack'
require 'rack/contrib'
require 'sass/plugin/rack'

#use Rack::Profiler if ENV['RACK_ENV'] == 'development'

use Rack::Locale
use Sass::Plugin::Rack

run Boutique::Application
