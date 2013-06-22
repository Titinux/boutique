class RemoveActivatedColumnFromUsersTable < ActiveRecord::Migration
  def up
    remove_column :users, :activated
  end

  def down
    add_column :users, :activated, :boolean, default: false, null: false
  end
end
