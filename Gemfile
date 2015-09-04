# Edit this Gemfile to bundle your application's dependencies.
source 'https://rubygems.org'

# Rails
gem 'rails', '4.2.4'
gem 'rails-i18n'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

# Rails 3 compatibility
gem 'rails-observers'
gem 'activerecord-session_store'

# Database
gem 'pg'

# Cache
gem 'dalli'

# Javascript
gem 'jquery-rails'

# Security
gem 'devise'
gem 'devise-i18n'
gem 'devise-encryptable', '>= 0.1.2'

# Models
gem 'state_machine'

# Controllers
gem 'responders'
gem 'ransack'
gem 'cells', '< 4.0.0'

# Views
gem 'haml'
gem 'simple_form'
gem 'show_for'
gem 'kaminari'

gem 'compass-rails'
gem 'bootstrap-sass'

# Others
#gem 'javan-whenever', lib: false, source: 'http://gems.github.com'
gem 'rack-contrib'
gem 'sidekiq'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'guard-rspec'
  gem 'rb-fsevent'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
end

group :production do
  # Use unicorn as the web server
  gem 'unicorn'
end
