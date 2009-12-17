class RenameDepositsTable < ActiveRecord::Migration
  def self.up
    rename_table("deposites", "deposits")
  end

  def self.down
    rename_table("deposits", "deposites")
  end
end
