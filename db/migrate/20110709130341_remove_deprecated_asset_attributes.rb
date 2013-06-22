class RemoveDeprecatedAssetAttributes < ActiveRecord::Migration
  def up
    remove_column :assets, :unitaryPrice
    remove_column :assets, :floatPrice
  end

  def down
    add_column :assets, :unitaryPrice, :decimal, precision: 10, scale: 2, null: false, default: 0
    add_column :assets, :floatPrice,   :boolean, null: false, default: false
  end
end
