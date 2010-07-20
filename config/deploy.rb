set :application, "boutique.hyze.bagu.biz"
set :repository,  "git://github.com/titinux/boutique.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "192.168.11.2"
role :web, "192.168.11.2"
role :db,  "192.168.11.2", :primary => true

set :user, 'root'
set :use_sudo, false
set :rails_env, 'production'

namespace :deploy do
  desc "Copy database configration file in the application"
  task :copy_database_configuration do
    production_db_config = "#{deploy_to}/config/production.database.yml"
    run "cp #{production_db_config} #{release_path}/config/database.yml"
  end
end

namespace :deploy do
  namespace :assets do
    desc "Make symlinks"
    task :symlink, :roles => :app do
      assets.create_dirs
      run "rm -rf #{release_path}/public/images && ln -nfs #{shared_path}/images #{release_path}/public/images"
    end

    desc "Create directories"
    task :create_dirs, :roles => :app do
      %w(index pictures).each do |name|
        run "mkdir -p #{shared_path}/#{name}"
      end
    end

    desc "Create asset packages for production"
    task :package, :roles => [:web] do
      run <<-EOF
        cd #{release_path} && rake asset:packager:build_all
      EOF
    end
  end
end

namespace :deploy do
  desc "Restarting passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

after "deploy:update_code" , "deploy:copy_database_configuration"
after "deploy:update_code" , "assets:symlink"
after "deploy:update_code",  "assets:package"
after "deploy:symlink", "deploy:update_crontab"

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"
