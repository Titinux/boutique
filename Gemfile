# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'

# Rails
gem 'rails', '3.2.13'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'

  # Javascript
  gem 'jquery-rails'
end

# Security
gem 'devise'
gem 'devise-encryptable'

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
gem 'delayed_job_active_record'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  # Database
  gem 'sqlite3'

  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'pry-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'

  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  # Database
  gem 'pg'

  # Cache
  gem 'dalli'
end
