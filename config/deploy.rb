# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2011 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

require 'rvm/capistrano'
#require 'bundler/capistrano'

load    'config/deploy/capistrano_database'
load    'config/deploy/rvmrc'

set :bundle_flags, "--deployment"

set :application, 'boutique'
set :repository,  'git://github.com/Titinux/boutique.git'

# Servers settings
role :app, 'Haruna.lan'
role :web, 'Haruna.lan'
role :db,  'Haruna.lan', :primary => true

set :user, "hyze.fr"
set :use_sudo, false
set :rails_env, 'production'

# Deployment location
set :deploy_to, "/home/hyze.fr/web_apps/#{application}"

# SCM
set :scm, :git
set :branch, '1.1'
set :deploy_via, :remote_cache

# RVM
set :rvm_type, :user
set :rvm_ruby_string, '1.9.2-p180@boutique'

namespace :bundle do
  task :install do
    desc "Bundle production gems"
    run "cd #{release_path} && bundle install --without development test"
  end
end

namespace :deploy do
  task :start do
    desc 'Start unicorn server'
    run "unicorn -c #{deploy_to}/current/config/unicorn.rb -E production -D"
  end

  task :stop do
    desc 'Stop unicorn server'
    run "if [ -f #{shared_path}/pids/unicorn.pid ]; then kill -s QUIT `cat #{shared_path}/pids/unicorn.pid` fi"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    desc 'Reload unicorn server'
    run "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
  end

  task :asset_symlink, :except => { :no_release => true } do
    run "rm -rf #{release_path}/app/assets/images"
    run "ln -nfs #{shared_path}/images #{release_path}/app/assets/images"
  end

  task :sockets, :except => { :no_release => true } do
    run "ln -nfs #{shared_path}/sockets #{release_path}/tmp/sockets"
  end
end

after "deploy:finalize_update", "deploy:sockets"
after "deploy:finalize_update", "deploy:asset_symlink"
after "deploy:update_code", "bundle:install"

#namespace :deploy do
#  desc "Update the crontab file"
#  task :update_crontab, :roles => :db do
#    run "cd #{release_path} && whenever --update-crontab #{application}"
#  end
#end

#after "deploy:symlink",      "deploy:update_crontab"

#after "deploy:stop",    "delayed_job:stop"
#after "deploy:start",   "delayed_job:start"
#after "deploy:restart", "delayed_job:restart"

