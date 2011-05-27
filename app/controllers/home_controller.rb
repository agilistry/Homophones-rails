class HomeController < ApplicationController
  def about
  end
  
  def home
    @riddle = Question.random_riddle
    @homophone_sets = HomophoneSet.random(4).map(&:homophones)
    @all_homophones = HomophoneSet.all_homophones
  end
end
