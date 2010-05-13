class Homophone < ActiveRecord::Base
  include Comparable
  validates_presence_of :name, :message => 'Please enter the missing word'
  
  def <=>(other)
    name.downcase <=> other.name.downcase
  end
end
