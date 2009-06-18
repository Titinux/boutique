class AddActivationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :activationKey, :string, { :length => 64 }
    add_column :users, :activated, :boolean, { :null => false, :default => false }
    
    User.update_all(:activated => true)
  end

  def self.down
    remove_column :users, :activated
    remove_column :users, :activationKey
  end
end
