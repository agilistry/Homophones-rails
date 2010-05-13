class HomophoneSetsController < ApplicationController

  def index
    response.headers['Cache-Control'] = 'public, max-age=86400'
    @homophone_lists = HomophoneSet.all(:include => :homophones).map(&:homophones).sort
  end

end
