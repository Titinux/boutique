class AddDofusNicknamesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :dofusNicknames, :string, { :limit => 255 }
  end

  def self.down
    remove_column :users, :dofusNicknames
  end
end
