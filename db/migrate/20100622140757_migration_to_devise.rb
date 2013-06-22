class MigrationToDevise < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.rename   'password_hash', 'encrypted_password'

      t.string   'reset_password_token'

      t.integer  'sign_in_count', null: false, default: 0

      t.datetime 'current_sign_in_at'
      t.string   'current_sign_in_ip'


      t.datetime 'last_sign_in_at'
      t.string   'last_sign_in_ip'

      t.rename   'activationKey', 'confirmation_token'

      t.datetime 'confirmed_at'
      t.datetime 'confirmation_sent_at'

      t.integer  'failed_attempts', null: false, default: 0
      t.datetime 'locked_at'
    end


    change_column_default :users, 'encrypted_password', ''
    change_column :users, 'encrypted_password', :string, limit: 128, null: false

    change_column_default :users, 'password_salt', ''
    change_column :users, 'password_salt', :string, null: false

    User.update_all(['confirmed_at = ?', Time.now], ['activated = ?', true])
    remove_column :users, 'admin'

    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
  end

  def self.down
    remove_index :users, :confirmation_token
    remove_index :users, :reset_password_token

    add_column :users, 'admin',     :boolean, default: false, null: false
    add_column :users, 'activated', :boolean, default: false, null: false
    User.update_all(['activated = ?', true], 'confirmed_at is not NULL')

    #change_column :users, 'password_salt', :string, null: false
    #change_column_default :users, 'password_salt', ''

    #change_column :users, 'encrypted_password', :string, limit: 128, null: false
    #change_column_default :users, 'encrypted_password', ''

    change_table :users do |t|
      t.remove 'locked_at'
      t.remove 'failed_attempts'
      t.remove 'confirmation_sent_at'
      t.remove 'confirmed_at'

      t.rename 'confirmation_token', 'activationKey'

      t.remove 'last_sign_in_ip'
      t.remove 'current_sign_in_ip'
      t.remove 'last_sign_in_at'
      t.remove 'current_sign_in_at'
      t.remove 'sign_in_count'
      t.remove 'reset_password_token'

      t.rename 'encrypted_password', 'password_hash'
    end
  end
end
