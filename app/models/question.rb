class Question < ActiveRecord::Base
  validates_presence_of :response_size, :responses, :ask
  
  def self.random_riddle
    first :conditions => 'riddle_response IS NOT NULL', :order => 'RANDOM()'
  end
end
