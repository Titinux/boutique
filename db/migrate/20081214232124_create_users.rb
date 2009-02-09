class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string     :name, :limit => 25, :null => false
      t.integer    :pigMoneyBox, :null => false, :default => 0 
      t.references :guild, :null => false
      t.boolean    :admin, :null => false, :default => false
      t.string     :email, :limit => 50
      t.string     :password_salt
      t.string     :password_hash

      t.timestamps
    end
    
    add_index :users, :name, :unique => true
  end

  def self.down
    remove_index :users, :name
    drop_table :users
  end
end
