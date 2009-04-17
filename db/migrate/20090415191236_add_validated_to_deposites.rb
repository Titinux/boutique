class AddValidatedToDeposites < ActiveRecord::Migration
  def self.up
    add_column :deposites, :validated, :boolean, { :null => false, :default => false }
    change_column_null :deposites, :user_id, :integer, false
    change_column_null :deposites, :asset_id, :integer, false
  end

  def self.down
  end
end
