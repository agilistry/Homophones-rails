class HomophoneSetGrouper
  def self.by_first_letter(homsets)
    groups = homsets.group_by(&:index_letter)
    ordered = ActiveSupport::OrderedHash.new
    groups.sort.each {|key, sets| ordered[key] = sets }
    ordered
  end
end

module HomeHelper

  def grouped_by_first_letter(lists)
    HomophoneSetGrouper.by_first_letter(lists)
  end

end
