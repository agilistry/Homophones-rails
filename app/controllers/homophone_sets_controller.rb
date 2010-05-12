class HomophoneSetsController < ApplicationController
  def new
    @homophone_set = HomophoneSet.new
    8.times { @homophone_set.homophones.build }
  end
end
