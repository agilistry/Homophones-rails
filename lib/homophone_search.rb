class HomophoneSearch
  class << self
    def search_by_homophone(search_string)
      matched_homophones = Homophone.find(:all, :conditions => {:name => search_string})
      matched_sets = HomophoneSet.find_and_return_phones(matched_homophones.collect(&:homophone_set_id))
      HomophoneSetGrouper.by_first_letter(matched_sets)
    end
  end
end