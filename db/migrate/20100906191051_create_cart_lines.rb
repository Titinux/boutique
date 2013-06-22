class CreateCartLines < ActiveRecord::Migration
  def self.up
    create_table :cart_lines do |t|
      t.references :cart,     null: false
      t.references :asset,    null: false
      t.integer    :quantity, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :cart_lines
  end
end
