class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string     :name, :null => false, :limit => 25
      t.string     :pictureUri
      t.references :parent

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
