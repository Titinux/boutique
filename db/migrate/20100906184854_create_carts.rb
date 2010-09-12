class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.references :user,    :null => false
      t.string     :name
      t.boolean    :current, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
