# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'rack'
require 'rack/contrib'


#use Rack::Profiler if ENV['RACK_ENV'] == 'development'
run Boutique::Application
