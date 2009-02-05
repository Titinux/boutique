class CreateOrderLines < ActiveRecord::Migration
  def self.up
    create_table :order_lines do |t|
      t.references :order, :null => false
      t.references :asset, :null => false
      t.integer    :quantity, :null => false
      t.integer    :unitaryPrice, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :order_lines
  end
end
