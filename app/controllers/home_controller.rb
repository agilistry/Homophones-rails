class HomeController < ApplicationController
  def home
    response.headers['Cache-Control'] = 'public, max-age=86400'
    @homophone_lists = HomophoneSet.all(:include => :homophones).map(&:homophones).sort
  end

  def about
  end
end
