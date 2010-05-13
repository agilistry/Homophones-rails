class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :ask
      t.integer :response_size
      t.string :responses

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
