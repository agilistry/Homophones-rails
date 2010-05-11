class CreateLogins < ActiveRecord::Migration
  def self.up
    create_table :logins do |t|
      t.string :user_name
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :logins
  end
end
