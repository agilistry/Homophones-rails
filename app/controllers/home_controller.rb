class HomeController < ApplicationController
  def home
    @homophone_lists = HomophoneSet.all.map &:homophones
  end

  def about
  end
end
