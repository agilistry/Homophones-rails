class HomophoneSetsController < ApplicationController

  def index
    response.headers['Cache-Control'] = 'public, max-age=86400'
    @homophone_lists = HomophoneSet.all_homophones
  end

  def search
    @grouped_hom_list = HomophoneSearch.search_by_homophone params[:search_term]
  end

end
