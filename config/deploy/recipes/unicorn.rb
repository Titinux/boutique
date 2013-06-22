set_default(:unicorn_user) { user }
set_default(:unicorn_pid) { "#{shared_path}/pids/unicorn.pid" }
set_default(:unicorn_config) { "#{shared_path}/config/unicorn.rb" }
set_default(:unicorn_out_log) { "#{shared_path}/log/unicorn.stdout.log" }
set_default(:unicorn_err_log) { "#{shared_path}/log/unicorn.stderr.log" }
set_default(:unicorn_socket) { "#{shared_path}/sockets/unicorn.sock" }
set_default(:unicorn_workers, 2)

namespace :unicorn do
  desc "Setup Unicorn initializer and app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "unicorn.rb.erb", unicorn_config
  end
  after "deploy:setup", "unicorn:setup"

  task :start do
    desc 'Start unicorn server'
    run "cd #{current_path}; bundle exec unicorn -c #{unicorn_config} -E #{rails_env} -D"
  end

  task :stop do
    desc 'Stop unicorn server'
    run "if [ -f #{shared_path}/pids/unicorn.pid ]; then kill -s QUIT `cat #{shared_path}/pids/unicorn.pid`; fi"
  end

  task :restart, roles: :app, except: { no_release: true } do
    desc 'Reload unicorn server'
    run "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
  end

  %w[start stop restart].each do |command|
    after "deploy:#{command}", "unicorn:#{command}"
  end

  task :sockets_directory, role: :app, except: { no_release: true } do
    desc 'Create the sockets directory'
    run "mkdir #{shared_path}/sockets"
  end
  after "deploy:setup", "unicorn:sockets_directory"

end
