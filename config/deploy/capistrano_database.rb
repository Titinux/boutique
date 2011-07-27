unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end

  namespace :deploy do

    namespace :db do

      desc <<-DESC
Creates the database.yml configuration file in shared path.

By default, this task uses a template unless a template \
called database.yml.erb is found either is :template_dir \
or /config/deploy folders. The default template matches \
the template for config/database.yml file shipped with Rails.

When this recipe is loaded, db:setup is automatically configured \
to be invoked after deploy:setup. You can skip this task setting \
the variable :skip_db_setup to true. This is especially useful \
if you are using this recipe in combination with \
capistrano-ext/multistaging to avoid multiple db:setup calls \
when running deploy:setup for all stages one by one.
DESC
      task :setup, :except => { :no_release => true } do
        location = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
        template = File.read(location) if File.file?(location)

        config = ERB.new(template)

        run "mkdir -p #{shared_path}/db"
        run "mkdir -p #{shared_path}/config"
        put config.result(binding), "#{shared_path}/config/database.yml"
      end

      desc <<-DESC
[internal] Updates the symlink for database.yml file to the just deployed release.
DESC
      task :symlink, :except => { :no_release => true } do
        run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      end

    end

    after "deploy:setup", "deploy:db:setup" unless fetch(:skip_db_setup, false)
    after "deploy:finalize_update", "deploy:db:symlink"

  end
