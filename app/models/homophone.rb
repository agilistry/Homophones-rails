class Homophone < ActiveRecord::Base
  validates_presence_of :name, :message => 'Please enter the missing word'
end
