class CreateHomophoneSets < ActiveRecord::Migration
  def self.up
    create_table :homophone_sets do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :homophone_sets
  end
end
