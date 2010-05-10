class HomeController < ApplicationController
  def home
    @name = params[:name] || 'Agilistry'
  end
end
