require 'spec_helper'

describe Login do
  before(:each) do
    @valid_attributes = {
      :user_name => "value for user_name",
      :password => "value for password"
    }
  end

  it "should create a new instance given valid attributes" do
    Login.create!(@valid_attributes)
  end
end
