module HomeHelper

  def grouped_by_first_letter(lists)
    groups = lists.group_by {|list| list.first.name[0].chr.downcase }
    ordered = ActiveSupport::OrderedHash.new
    groups.sort.each {|key, sets| ordered[key] = sets }
    ordered
  end

end
