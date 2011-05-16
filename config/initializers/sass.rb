require 'sass/plugin'

Sass::Plugin.options[:template_location] = "#{Rails.root}/app/sass"
Sass::Plugin.options[:cache_location]    = "#{Rails.root}/tmp/sass_cache"
Sass::Plugin.options[:property_syntax]   = :new

if Rails.env == 'production'
  Sass::Plugin.options[:style] = :compressed
end

if Rails.env == 'developpement'
  Sass::Plugin.options[:style] = :expanded
  Sass::Plugin.options[:line_numbers] = true
end
