# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'

# Rails
gem 'rails',        '~> 3.1.0.rc1'

# Asset template engines
gem 'sass'
gem 'coffee-script'
gem 'uglifier'

# Database
gem 'mysql2'

# Javascript
gem 'jquery-rails'

# Security
gem 'devise'

# Controllers
gem 'responders'
gem 'meta_search',   :git => 'git://github.com/ernie/meta_search.git'

# Views
gem 'haml'
gem 'simple_form'
gem 'show_for'
gem 'kaminari'

# Use unicorn as the web server
gem 'unicorn'

# Others
#gem 'javan-whenever', :lib => false, :source => 'http://gems.github.com'
gem 'rack-contrib'
gem 'delayed_job'

group :development, :test do
  gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git', :branch => '3_1_compatibility'
  gem 'factory_girl_rails', '1.1.beta1'

  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'rspec-core', '2.6.2'
  gem 'rspec-rails', '2.6.1.beta1'
  gem 'spork'
  gem 'launchy'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
