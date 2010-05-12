class HomophoneSet < ActiveRecord::Base
  has_many :homophones, :order => 'name ASC'
  validate :validate_at_least_2_homophones

  def validate_at_least_2_homophones
    if homophones.size < 2
      errors.add(:base, "Please create at least 2 homophones for a complete set")
    end
  end
end
