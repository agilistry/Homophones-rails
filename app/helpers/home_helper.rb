module HomeHelper

  def grouped_by_first_letter(lists)
    HomophoneSetGrouper.by_first_letter(lists)
  end

end
