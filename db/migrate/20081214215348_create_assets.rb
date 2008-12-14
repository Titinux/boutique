class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string     :name, :limit => 25, :null => false
      t.references :category, :null => false
      t.string     :pictureUri, :limit => 255
      t.decimal    :unitaryPrice, :precision => 10, :scale => 2, :null => false, :default => 0
      t.boolean    :floatPrice, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
