class HomeController < ApplicationController
  def home
    @grouped_hom_list = grouped_by_first_letter(HOM_LIST)
  end

  private
  def grouped_by_first_letter(lists)
    lists.group_by {|list| list.first.name[0].chr.downcase }
  end
end
