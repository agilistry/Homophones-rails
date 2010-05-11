class AdminController < ApplicationController
  before_filter :login_required, :except => :login

  def login_required
    redirect_to(login_path) unless session[:logged_in]
  end
  
  def login
    if params[:login] && params[:login][:user_name] == 'alan' && params[:login][:password] == 'h0m0ph0n3s'
      session[:logged_in] = true
      redirect_to admin_path
    end
  end
end