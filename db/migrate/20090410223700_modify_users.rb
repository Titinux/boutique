class ModifyUsers < ActiveRecord::Migration
  def self.up
    change_column(:users, :guild_id, :integer, null: true)

  end

  def self.down
  end
end
