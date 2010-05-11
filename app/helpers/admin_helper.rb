module AdminHelper
  def authenticate(username, password)
    session[:logged_in] = (username == $admin_username && password == $admin_password)
  end
end