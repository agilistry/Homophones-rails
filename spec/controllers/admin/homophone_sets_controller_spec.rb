require 'spec_helper'

describe Admin::HomophoneSetsController, 'GET new' do
  stub_admin_logged_in

  it "is successful" do
    get :new
    response.should be_success
  end

  context "integrated" do
    integrate_views
    
    it "is successful" do
      get :new
      response.should be_success
    end
  end
  
  it "rejects the user if not logged in" do
    controller.stub(:admin_logged_in?).and_return false
    get :new
    response.should redirect_to(admin_login_path)
  end
end

describe Admin::HomophoneSetsController, 'POST create' do
  stub_admin_logged_in

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

  it "rejects the user if not logged in" do
    controller.stub(:admin_logged_in?).and_return false
    post :create
    response.should redirect_to(admin_login_path)
  end

  context "failure" do
    integrate_views

    it "renders the new form" do
      post :create, :homophone_set => {:homophones => {}}
      response.should render_template('new')
    end

    it "shows 8 form rows" do
      homophones = {}
      1.upto(8) {|i| homophones[i.to_s] = {}}
      post :create, :homophone_set => {:homophones => homophones}
      assert_select 'input.name', :count => 8
      assert_select 'input.definition', :count => 8
    end
  end

end

describe Admin::HomophoneSetsController, 'GET edit' do
  stub_admin_logged_in
  
  let(:homophone_set) { create_homophone_set }
  
  def do_get
    get :edit, :id => homophone_set.to_param
  end

  it "is successful" do
    do_get
    response.should be_success
  end

  context "integrated" do
    integrate_views
    
    it "is successful" do
      do_get
      response.should be_success
    end
  end
  
  it "rejects the user if not logged in" do
    controller.stub(:admin_logged_in?).and_return false
    do_get
    response.should redirect_to(admin_login_path)
  end
end

describe Admin::HomophoneSetsController, 'PUT update' do
  stub_admin_logged_in
  
  let(:homophone_set) do
    create_homophone_set :homophones => [
      Homophone.new(:name => 'a'),
      Homophone.new(:name => 'ay'),
      Homophone.new(:name => 'eh')
    ]
  end

  it "replaces the homophones in the database" do
    homophone_set # load that beeyotch
    expect {
      put :update, :id => homophone_set.to_param,
          :homophone_set => {:homophones => {
        '1' => {:name => 'to'},
        '2' => {:name => 'eh'}}}
    }.to change(Homophone, :count).from(3).to(2)
  end
  
  it "redirects to the admin page" do
    put :update, :id => homophone_set.to_param,
        :homophone_set => {:homophones => {
      '1' => {:name => 'to'},
      '2' => {:name => 'eh'}}}
    response.should redirect_to(admin_index_path)
  end

  context "failed" do
    def do_put
      put :update, :id => homophone_set.to_param,
          :homophone_set => {:homophones => {
        '1' => {:name => 'a'}}}      
    end

    it "renders the edit template" do
      do_put
      response.should render_template('edit')
    end
  end
end
