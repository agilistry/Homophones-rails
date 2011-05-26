class Homophone < ActiveRecord::Base
  alias_method :original_equals_equals, :==

  include Comparable
  validates_presence_of :name, :message => 'Please enter the missing word'
  
  def <=>(other)
    name.downcase.tr("'", "") <=> other.name.downcase.tr("'", "")
  end

  def ==(comparison_object)
    original_equals_equals(comparison_object)
  end
  
  def index_letter
    name.first.downcase
  end
end
