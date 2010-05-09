require 'spec_helper'

describe "Our starter suite" do
  it "should be awesome" do
    suite = Object.new
    def suite.awesome?
      true
    end
    suite.should be_awesome
  end
end