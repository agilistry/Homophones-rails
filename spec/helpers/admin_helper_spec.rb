require 'spec_helper'

describe AdminHelper, '#authenticate' do
  before(:each) do
    Login.create! :user_name => 'alan', :password => 'password'
  end

  context "successful authentication" do
    it "sets session[:logged_in] to true" do
      helper.authenticate 'alan', 'password'
      session[:logged_in].should be_true
    end

    it "returns true" do
      helper.authenticate('alan', 'password').should be_true
    end
  end

  context "failed authentication" do
    it "returns false" do
      helper.authenticate('alan', 'wrong').should be_false
    end

    it "resets session[:logged_in] to nil" do
      session[:logged_in] = true
      helper.authenticate 'alan', 'wrong'
      session[:logged_in].should be_false
    end
  end
end
