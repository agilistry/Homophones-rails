class HomophoneSet < ActiveRecord::Base
  has_many :homophones, :order => 'name ASC'
end
