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

  after "deploy:update_code" , "deploy:copy_database_configuration"
end
