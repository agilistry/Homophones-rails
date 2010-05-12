require 'spec_helper'

describe Homophone do
  before(:each) do
    @valid_attributes = {
      :homophone_set_id => 1,
      :name => "value for name",
      :definition => "value for definition"
    }
  end

  it "should create a new instance given valid attributes" do
    Homophone.create!(@valid_attributes)
  end
end
