class SetupUsersWithOldDeviseFields < ActiveRecord::Migration
  def self.up
    add_column :users, :password_salt, :string
    add_column :users, :remember_token, :string
    add_column :users, :remember_token_created_at, :datetime
  end

  def self.down
    remove_column :users, :password_salt
    remove_column :users, :remember_token
    remove_column :users, :remember_token_created_at
  end
end
