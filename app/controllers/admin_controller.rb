class AdminController < ApplicationController
  before_filter :login_required, :except => :login
  include AdminHelper

  def login_required
    redirect_to(login_path) unless logged_in?
  end
  
  def login
    if params[:login] && authenticate(params[:login][:user_name], params[:login][:password])
      redirect_to admin_path
    end
  end
end