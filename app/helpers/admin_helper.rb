module AdminHelper
  def authenticate(username, password)
    session[:logged_in] = Login.find_by_user_name_and_password(username, password).present?
  end
end