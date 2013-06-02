# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2013 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
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

require "bundler/capistrano"

load "deploy/assets"

load "config/recipes/base"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/app_config"
load "config/recipes/rbenv"
load "config/recipes/check"

role :web, 'hyze.lan'
role :app, 'hyze.lan'
role :db,  'hyze.lan', :primary => true

set :user, "hyze"
set :application, "boutique"
set :deploy_to, "/home/#{user}/public/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git://github.com/Titinux/boutique.git"
set :branch, "1.2"

default_run_options[:pty] = true
set :ssh_options, {forward_agent: true}

namespace :cache do
  desc "Set right permissions on directories"
  task :permissions do
    run "chmod 777 #{release_path}/public"
  end
end

namespace :uploads do
  desc "Symlink uploads path"
  task :symlink do
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
end

namespace :assets do
  task :symlink, :except => { :no_release => true } do
    run "rm -rf #{release_path}/app/assets/images"
    run "ln -nfs #{shared_path}/images #{release_path}/app/assets/images"
  end
end

after "deploy", "deploy:cleanup" # keep only the last 5 releases

after "deploy:finalize_update", "uploads:symlink"
after "deploy:finalize_update", "assets:symlink"
after "deploy:finalize_update", "cache:permissions"
