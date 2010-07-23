class DeviseCreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table(:administrators) do |t|
      t.string :name, :null => false, :limit => 25
      t.database_authenticatable :null => false
      t.trackable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :none

      t.timestamps
    end

    add_index :administrators, :name, :unique => true
    add_index :administrators, :email, :unique => true
  end

  def self.down
    drop_table :administrators
  end
end
