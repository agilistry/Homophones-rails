require 'spec_helper'

describe HomeController, 'GET home' do
  integrate_views
  stub_devise_logged_out

  it "is successful" do
    create_homophone_set
    get :home
    response.should be_success
  end

  it "is successful with no questions that have riddle responses" do
    create_question :riddle_response => nil
    get :home
    response.should be_success
    response.body.should_not include('Riddle')
  end

  it "is successful when there is a question with a riddle response" do
    create_question :riddle_response => "a bored board"
    get :home
    response.should be_success
    response.body.should include('Riddle')
    response.body.should include('a bored board')
  end
end
