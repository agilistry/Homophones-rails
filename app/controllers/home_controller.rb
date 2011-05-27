class HomeController < ApplicationController
  def about
  end
  
  def home
    @riddle = Question.random_riddle
    @grouped_homophone_sets = HomophoneSet.all_including_homophones.sort.group_by(&:index_letter)
  end
end
