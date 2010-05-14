class HomophoneSetsController < ApplicationController

  def index
  end

  def search
    @grouped_hom_list = HomophoneSearch.search_by_homophone params[:search_term]
  end

end
