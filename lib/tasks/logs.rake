namespace :logs do
  desc "Prune old logs in database"
  task :prune => :environment do
    ActiveRecord::Base.connection.execute("DELETE FROM `logs` WHERE (`created_at` < now() - INTERVAL 60 DAY)")
  end
end
