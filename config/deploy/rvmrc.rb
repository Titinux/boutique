namespace :deploy do
  desc <<-DESC
Make the .rvmrc file
DESC
    task :rvmrc, :except => { :no_release => true } do
      location = fetch(:template_dir, "config/deploy/templates") + '/rvmrc.erb'
      template = File.read(location) if File.file?(location)

      config = ERB.new(template)

      put config.result(binding), "#{release_path}/.rvmrc"
    end

  after "deploy:finalize_update", "deploy:rvmrc"
end
