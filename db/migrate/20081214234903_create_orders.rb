class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.references :user, null: false
      t.integer    :state, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
