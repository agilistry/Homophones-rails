require 'spec_helper'

describe Homophone, 'sorting' do

  RSpec::Matchers.define :sort_to do |expected|
    match do |actual|
      homophones = actual.map {|name| Homophone.new :name => name }
      homophones.sort.map(&:name).should == expected
    end
  end

  it "is by name ascending" do
    %w(erl earl url).should sort_to %w(earl erl url)
  end

  it "is case-insensitive" do
    %w(URL erl).should sort_to %w(erl URL)
  end

  it "ignores apostrophes" do
    ["e'er", 'earl'].should sort_to ['earl', "e'er"]
  end
end
