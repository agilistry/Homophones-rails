class AdminController < ApplicationController
  before_filter :login_required, :except => :login
  include AdminHelper
  
  def login
    if params[:login] && authenticate(params[:login][:user_name], params[:login][:password])
      redirect_to admin_index_path
    end
  end
  
  def logout
    session[:logged_in] = false
    redirect_to :root
  end
  
  def index
    redirect_to admin_homophone_sets_path
  end

  private
  
  def login_required
    redirect_to(admin_login_path) unless admin_logged_in?
  end
end
