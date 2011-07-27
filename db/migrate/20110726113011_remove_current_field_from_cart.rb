class RemoveCurrentFieldFromCart < ActiveRecord::Migration
  def up
    remove_column :carts, :current
  end

  def down
    add_column :carts, :current, :boolean, :null => false, :default => false
  end
end
