require 'spec_helper'

describe AdminController, 'GET /' do
  it "redirects to login page if not logged in" do
    get :index
    response.should redirect_to(new_user_session_path)
  end

  it "redirects non-admin users to the login page" do
    sign_in create_user(:confirmed => true)
    get :index
    response.should redirect_to(new_user_session_path)
  end
  
  it "redirects to homophones admin page if logged in as admin" do
    sign_in create_user(:admin => true, :confirmed => true)
    get :index
    response.should redirect_to(admin_homophone_sets_path)
  end
end
