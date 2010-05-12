class CreateHomophones < ActiveRecord::Migration
  def self.up
    create_table :homophones do |t|
      t.integer :homophone_set_id
      t.string :name
      t.string :definition

      t.timestamps
    end
  end

  def self.down
    drop_table :homophones
  end
end
