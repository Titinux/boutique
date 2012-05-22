class MigrateToDevise2 < ActiveRecord::Migration
  def up
    change_table :users do |t|
      ## Recoverable
      t.datetime :reset_password_sent_at

      ## Confirmable
      t.string :unconfirmed_email
    end
  end

  def down
    remove_column :users, :unconfirmed_email
    remove_column :users, :reset_password_sent_at
  end
end
