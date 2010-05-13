class HomophoneSet < ActiveRecord::Base
  has_many :homophones, :order => 'LOWER(name) ASC', :dependent => :destroy
  validate :validate_at_least_2_homophones
  validate :validate_homophones_are_valid
  validate :delete_errors_from_homophones_attribute

  def fill_empty_homophones(num)
    homophones.size.upto(num - 1) { homophones.build }
  end

  def validate_at_least_2_homophones
    if homophones.size < 2
      errors.add(:base, "Please create at least 2 homophones for a complete set")
    end
  end

  def validate_homophones_are_valid
    errors.add(:base, "Some homophones are invalid") unless homophones.all?(&:valid?)
  end

  def delete_errors_from_homophones_attribute
    errors.instance_variable_get('@errors').delete 'homophones'
  end
end
