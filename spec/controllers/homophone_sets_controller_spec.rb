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

describe HomophoneSetsController, 'POST create' do
  def do_post
    post :create, :homophone_set => {:homophones => {
      '1' => {:name => 'a', :definition => 'short little word'},
      '2' => {:name => 'eh', :definition => 'interrogative'} }}
  end

  it "creates a new HomophoneSet" do
    expect { do_post }.to change(HomophoneSet, :count).by(1)
  end

  it "creates n new Homophones" do
    expect { do_post }.to change(Homophone, :count).by(2)
  end

  it "attaches the new Homophones to the new HomophoneSet" do
    do_post
    HomophoneSet.first.should have(2).homophones
  end
  
  it "ignores homophones with blank entries" do
    expect {
      post :create, :homophone_set => {:homophones => {
        '1' => {:name => 'a', :definition => 'short little word'},
        '2' => {:name => 'eh', :definition => 'interrogative'},
        '3' => {} }}
    }.to change(Homophone, :count).by(2)
  end
end
