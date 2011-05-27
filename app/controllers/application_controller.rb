class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  private
  def admin_required
    redirect_to new_user_session_path unless current_user && current_user.admin?
  end
end
