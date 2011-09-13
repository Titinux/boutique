# Rails
set :rails_env, 'production'

# SCM
set :repository,  'git://github.com/Titinux/boutique.git'
#set :branch, '1.2'

# RVM
set :rvm_ruby_string, '1.9.2-p180@boutique'

# Database
set :database, 'boutique'

# Deployment location
set :deploy_to, "/home/hyze.fr/web_apps/#{application}"
