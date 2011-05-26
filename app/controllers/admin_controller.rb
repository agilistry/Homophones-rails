class AdminController < ApplicationController 
  before_filter :authenticate_user!
  before_filter :check_for_admin

  def index
    redirect_to admin_homophone_sets_path
  end

  private
  def check_for_admin
    redirect_to new_user_session_path unless current_user.admin?
  end
end
