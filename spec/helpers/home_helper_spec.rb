require 'spec_helper'

describe HomeHelper, 'grouped_by_first_letter' do
  it "returns a hash of grouped homophone sets" do
    a_set = [OpenStruct.new(:name => 'a'), OpenStruct.new(:name => 'eh')]
    ads_set = [OpenStruct.new(:name => 'ads'), OpenStruct.new(:name => 'adds')]
    bask_set = [OpenStruct.new(:name => 'bask'), OpenStruct.new(:name => 'basque')]
    grouped = helper.grouped_by_first_letter [a_set, ads_set, bask_set]
    grouped['a'].should == [a_set, ads_set]
    grouped['b'].should == [bask_set]
  end

  it "is case-insensitive" do
    a_set = [OpenStruct.new(:name => 'a'), OpenStruct.new(:name => 'eh')]
    ads_set = [OpenStruct.new(:name => 'Ads'), OpenStruct.new(:name => 'adds')]
    grouped = helper.grouped_by_first_letter [a_set, ads_set]
    grouped['a'].should == [a_set, ads_set]
  end

  it "orders the keys alphabetically" do
    sets = [
      [OpenStruct.new(:name => 'b')],
      [OpenStruct.new(:name => 'a')],
      [OpenStruct.new(:name => 'f')],
      [OpenStruct.new(:name => 'r')],
      [OpenStruct.new(:name => 'm')],
      [OpenStruct.new(:name => 'z')],
      [OpenStruct.new(:name => 'e')],
    ]
    ordered_set = helper.grouped_by_first_letter sets
    ordered_set.should be_a(ActiveSupport::OrderedHash)
    ordered_set.keys.should == %w(a b e f m r z)
  end
end
