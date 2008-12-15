class CreateDeposites < ActiveRecord::Migration
  def self.up
    create_table :deposites do |t|
      t.references :user
      t.references :asset
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :deposites
  end
end
