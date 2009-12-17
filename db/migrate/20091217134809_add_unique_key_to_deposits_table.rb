class AddUniqueKeyToDepositsTable < ActiveRecord::Migration
  def self.up
    add_index :deposits, [:user_id, :asset_id, :validated], :unique => true
  end

  def self.down
    remove_index :deposits, :column => [:user_id, :asset_id, :validated]
  end
end
