class DeviseCreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table(:administrators) do |t|
      t.string :name, :null => false, :limit => 25

      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.datetime :locked_at

      t.timestamps
    end

    add_index :administrators, :name, :unique => true
    add_index :administrators, :email, :unique => true
  end

  def self.down
    drop_table :administrators
  end
end
