require 'spec_helper'

describe HomophoneSetGrouper, 'by_first_letter' do
  it "returns a hash of grouped homophone sets" do
    a_set = HomophoneSet.new :from => %w(a eh)
    ads_set = HomophoneSet.new :from => %w(ads adds)
    bask_set = HomophoneSet.new :from => %w(bask basque)
    grouped = HomophoneSetGrouper.by_first_letter [a_set, ads_set, bask_set]
    grouped['a'].should == [a_set, ads_set]
    grouped['b'].should == [bask_set]
  end

  it "is case-insensitive" do
    a_set = HomophoneSet.new :from => %w(a eh)
    ads_set = HomophoneSet.new :from => %w(Ads adds)
    grouped = HomophoneSetGrouper.by_first_letter [a_set, ads_set]
    grouped['a'].should == [a_set, ads_set]
  end

  it "orders the keys alphabetically" do
    sets = %w(b a f r m z e).map {|c| HomophoneSet.new :from => c }
    ordered_set = HomophoneSetGrouper.by_first_letter sets
    ordered_set.should be_a(ActiveSupport::OrderedHash)
    ordered_set.keys.should == %w(a b e f m r z)
  end
end