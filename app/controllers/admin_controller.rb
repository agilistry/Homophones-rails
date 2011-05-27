class AdminController < ApplicationController 
  before_filter :authenticate_user!
  before_filter :admin_required

  def index
    redirect_to admin_homophone_sets_path
  end
end
