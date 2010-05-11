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
end
