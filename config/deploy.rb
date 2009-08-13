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

namespace :deploy do
  task :copy_database_configuration do
    production_db_config = "#{deploy_to}/config/production.database.yml"
    run "cp #{production_db_config} #{release_path}/config/database.yml"
  end
end

namespace :assets do
  task :symlink, :roles => :app do
    assets.create_dirs
    run "rm -rf #{release_path}/public/images && ln -nfs #{shared_path}/images #{release_path}/public/images"
  end

  task :create_dirs, :roles => :app do
    %w(index pictures).each do |name|
      run "mkdir -p #{shared_path}/#{name}"
    end
  end
end

namespace :deploy do
  desc "Create asset packages for production" 
  task :after_update_code, :roles => [:web] do
    run <<-EOF
      cd #{release_path} && rake asset:packager:build_all
    EOF
  end
end

deploy.task :restart, :roles => :app do
  run "touch #{current_path}/tmp/restart.txt" 
end

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

after "deploy:update_code" , "deploy:copy_database_configuration"
after "deploy:update_code" , "assets:symlink"
after "deploy:symlink", "deploy:update_crontab"

