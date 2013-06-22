class CreateConfigTree < ActiveRecord::Migration
  def self.up
    create_table :config_tree do |t|
      t.string     :name, null: false
      t.string     :form_kind
      t.string     :type
      t.references :parent
      t.integer    :lft, null: false
      t.integer    :rgt, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :config_tree
  end
end
