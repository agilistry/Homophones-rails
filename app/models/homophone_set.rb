class HomophoneSet < ActiveRecord::Base
  include Comparable
  has_many :homophones, :dependent => :destroy
  
  
  validate :validate_at_least_2_homophones
  validate :validate_homophones_are_valid
  validate :delete_errors_from_homophones_attribute

  def self.random(limit)
    all :order => 'RANDOM()', :limit => limit 
  end

  def self.all_homophones
    sorted_homophones(all(:include => :homophones))
  end

  def self.find_and_return_phones(args)
    sorted_homophones(find(args))
  end

  def self.sorted_homophones(hom_sets)
    hom_sets.map(&:homophones).sort
  end

  def fill_empty_homophones(num)
    homophones.size.upto(num - 1) { homophones.build }
  end

  def <=>(other)
    homophones.sort.first <=> other.homophones.sort.first
  end

  protected
  def validate_at_least_2_homophones
    if homophones.size < 2
      errors.add(:base, "Please create at least 2 homophones for a complete set")
    end
  end

  def validate_homophones_are_valid
    errors.add(:base, "Some homophones are invalid") unless homophones.all?(&:valid?)
  end

  def delete_errors_from_homophones_attribute
    errors.delete :homophones
  end

end
