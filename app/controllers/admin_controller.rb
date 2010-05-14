class AdminController < ApplicationController
  before_filter :login_required, :except => :login
  include AdminHelper
  
  def login
    if params[:login] && authenticate(params[:login][:user_name], params[:login][:password])
      redirect_to admin_path
    end
  end
  
  def logout
    session[:logged_in] = false
    redirect_to home_path
  end
  
  def index
    redirect_to admin_homophone_sets_path
  end

  private
  
  def login_required
    redirect_to(login_path) unless logged_in?
  end
end
