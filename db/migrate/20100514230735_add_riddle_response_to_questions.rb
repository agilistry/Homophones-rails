class AddRiddleResponseToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :riddle_response, :string
  end

  def self.down
    remove_column :questions, :riddle_response
  end
end
