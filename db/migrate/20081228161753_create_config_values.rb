class CreateConfigValues < ActiveRecord::Migration
  def self.up
    create_table :config_values do |t|
      t.string     :name, :null => false
      t.references :config_tree, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :config_values
  end
end
