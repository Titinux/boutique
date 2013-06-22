class AddDispatchedToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :dispatched, :boolean, { null: false, default: false }
  end

  def self.down
    remove_column :orders, :dispatched
  end
end
