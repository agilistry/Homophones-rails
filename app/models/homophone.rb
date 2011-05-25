class Homophone < ActiveRecord::Base
  include Comparable
  validates_presence_of :name, :message => 'Please enter the missing word'
  
  def <=>(other)
    name.downcase.tr("'", "") <=> other.name.downcase.tr("'", "")
  end

  def ==(comparison_object)
    comparison_object.equal?(self) ||
      (comparison_object.instance_of?(self.class) &&
        comparison_object.id == id && !comparison_object.new_record?)
  end
end
