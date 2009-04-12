class AddGathererToUser < ActiveRecord::Migration
  def self.up
    add_column(:users, :gatherer, :boolean, options = {:null => false, :default => false})
  end

  def self.down
  end
end
