require 'spec_helper'

describe Question do
  before(:each) do
    @valid_attributes = {
      :id => 1,
      :ask => "What's your favorite homophone?",
      :response_size  => 1,
      :responses => "raise\nraze"
    }
  end

  it "should create a new instance given valid attributes" do
    Question.create!(@valid_attributes)
  end
end
