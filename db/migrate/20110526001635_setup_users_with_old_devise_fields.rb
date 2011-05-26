class SetupUsersWithOldDeviseFields < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end

  def self.up
    unless User.column_names.include?("password_salt")
      add_column :users, :password_salt, :string
    end

    unless User.column_names.include?("remember_token")
      add_column :users, :remember_token, :string
    end

    unless User.column_names.include?("remember_token_created_at")
      add_column :users, :remember_token_created_at, :datetime
    end
  end

  def self.down
    remove_column :users, :password_salt
    remove_column :users, :remember_token
    remove_column :users, :remember_token_created_at
  end
end

