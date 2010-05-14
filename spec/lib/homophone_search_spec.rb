require 'spec_helper'

describe HomophoneSearch, '::search_by_homophone' do
  before(:each) do
    Homophone.stub!(:find).and_return([])
    HomophoneSet.stub!(:find).and_return([])
  end
  
  it "should search all homophones for the given word" do
    Homophone.should_receive(:find).with(:all, :conditions => {:name => "erl"})
    HomophoneSearch.search_by_homophone("erl")
  end

  it "should find all the homophone sets that have a matched word" do
    Homophone.stub!(:find).and_return([new_homophone(:name => "erl", :homophone_set_id => 1)])
    HomophoneSet.should_receive(:find).with([1])
    HomophoneSearch.search_by_homophone("erl")
  end

  it "should collect all the matched sets into a hash that looks like a grouped list" do
    Homophone.stub!(:find).and_return([new_homophone(:name => "erl", :homophone_set_id => 1)])
    phones = [new_homophone(:name => "erl"), new_homophone(:name => "url")]
    results = [new_homophone_set(:homophones => phones)]
    HomophoneSet.stub!(:find).and_return(results)
    search_results = HomophoneSearch.search_by_homophone("erl")
    search_results["e"].should == [phones]
  end

end