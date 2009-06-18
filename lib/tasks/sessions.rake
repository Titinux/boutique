namespace :db do
  namespace :sessions do
    desc "Prune old sessions in database"
    task :prune => :environment do
      ActiveRecord::Base.connection.execute("DELETE FROM `sessions` WHERE (`updated_at` < now() - INTERVAL 15 DAY)")
    end
  end
end
