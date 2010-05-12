require 'spec_helper'

describe HomophoneSetsController, 'GET new' do
  it "is successful" do
    get :new
    response.should be_success
  end

  it "attaches 8 new homophones to the new homophone set" do
    get :new
    assigns[:homophone_set].should have(8).homophones
  end
  
  context "integrated" do
    integrate_views
    
    it "is successful" do
      get :new
      response.should be_success
    end
  end
end
