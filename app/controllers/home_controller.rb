class HomeController < ApplicationController
  def home
    @homophone_lists = HomophoneSet.all(:include => :homophones).map &:homophones
  end

  def about
  end
end
