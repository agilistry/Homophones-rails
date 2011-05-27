class HomeController < ApplicationController
  def about
  end
  
  def home
    @riddle = Question.random_riddle
    @all_homophones = HomophoneSet.all_homophones
  end
end
