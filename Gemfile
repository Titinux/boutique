# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'

# Rails
gem 'rails', '~> 3.1.0.rc5'
gem 'arel', '2.1.4' # Ne pas utiliser la version 2.1.5

# Asset template engines
gem 'sass-rails', :require => 'sass'
gem 'coffee-script'
gem 'uglifier'

# Javascript
gem 'jquery-rails'

# Security
gem 'devise'

# Controllers
gem 'responders'
gem 'meta_search', :git => 'git://github.com/ernie/meta_search.git'
gem 'cells'

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
  # Database
  gem 'sqlite3'

  gem 'factory_girl_rails'

  gem 'capybara'
  gem 'database_cleaner'
  gem 'rspec-rails'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  # Database
  gem 'pg'

  # Cache
  gem 'dalli'
end
