# Secret token
set_default(:app_config_secret_token, '4ca44741b0128f3552840f9b06effe9735de8c3a54924e6ccdd731a8f3f0be4649d93de26cf46bab09a76387d87eb7643c3bd0d2d3cb790b25ca7d90db264baa')

# Mailer settings
set_default(:app_config_mailer_delivery_method) { ':smtp' }
set_default(:app_config_mailer_raise_delivery_errors) { false }
set_default(:app_config_mailer_default_options_host) { 'boutique.hyze.fr' }

set_default(:app_config_mailer_smtp_address) { 'smtp.titinux.net' }
set_default(:app_config_mailer_smtp_domain) { 'boutique.hyze.fr' }
set_default(:app_config_mailer_smtp_port) { 25 }
set_default(:app_config_mailer_smtp_authentication) { 'plain' }
set_default(:app_config_mailer_smtp_startttls_auto) { false }
set_default(:app_config_mailer_smtp_user_name) { 'contact@boutique.hyze.fr' }
set_default(:app_config_mailer_smtp_password) { Capistrano::CLI.password_prompt "SMTP Password: " }

namespace :app_config do
  desc "Generate the application.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "application.yml.erb", "#{shared_path}/config/application.yml"
  end
  after "deploy:setup", "app_config:setup"

  desc "Symlink the application.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "app_config:symlink"
end
