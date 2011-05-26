class DropLogins < ActiveRecord::Migration
  def self.up
    drop_table :logins
  end

  def self.down
    create_table :logins do |t|
      t.string :user_name
      t.string :password

      t.timestamps
    end
  end
end
