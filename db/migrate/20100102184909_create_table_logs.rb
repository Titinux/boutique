class CreateTableLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.integer :level,      null: false, default: 0
      t.string  :user,       null: false
      t.string  :action,     null: false
      t.string  :objectType, null: false
      t.integer :objectId,   null: false
      t.text    :data

      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
