require 'spec_helper'

describe AdminController, 'POST /logout' do
  it "sets session[:logged_in] to false" do
    session[:logged_in] = true
    post :logout
    session[:logged_in].should be_false
  end

  it "redirects to the home page" do
    session[:logged_in] = true
    post :logout
    response.should redirect_to(home_path)
  end
end

describe AdminController, 'GET /' do
  it "redirects to login page if not logged in" do
    get :index
    response.should redirect_to(login_path)
  end
  
  it "redirects to homophones admin page if logged in" do
    session[:logged_in] = true
    get :index
    response.should redirect_to(admin_homophone_sets_path)
  end
end
