module HomeHelper
  def grouped_by_first_letter(lists)
    lists.group_by {|list| list.first.name[0].chr.downcase }
  end
end
