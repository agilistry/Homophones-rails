class AddIndexOnHomophoneNames < ActiveRecord::Migration
  def self.up
    add_index :homophones, :name
  end

  def self.down
    remove_index :homophones, :name
  end
end
