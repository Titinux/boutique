class ChangeUnitaryPriceOnOrderLines < ActiveRecord::Migration
  def self.up
    change_column :order_lines, :unitaryPrice, :decimal, :precision => 10, :scale => 2, :null => true
  end

  def self.down
  end
end
