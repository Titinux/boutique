# Rails
set :rails_env, 'staging'

# SCM
set :repository,  'git://github.com/Titinux/boutique.git'

# RVM
set :rvm_ruby_string, '1.9.2-p180@staging-boutique'

# Database
set :database, 'staging.boutique'

# Deployment location
set :deploy_to, "/home/hyze.fr/web_apps/staging.#{application}"
