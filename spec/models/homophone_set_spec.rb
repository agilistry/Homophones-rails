require 'spec_helper'

describe HomophoneSet, 'validations' do
  it "is invalid with 0 homophones" do
    set = HomophoneSet.new
    set.should_not be_valid
    set.should have_at_least(1).error_on(:base)
  end

  it "is valid with 2 homophones" do
    set = HomophoneSet.new
    2.times { set.homophones.build(:name => 'asdf') }
    set.should be_valid
  end

  context "one homophone is invalid" do
    let(:set) { HomophoneSet.new }

    before(:each) do
      set.homophones.build :name => 'to', :definition => 'little word'
      set.homophones.build :name => 'too', :definition => 'also'
      set.homophones.build :name => '', :definition => '1 more than 1'
    end

    it "is invalid" do
      set.should_not be_valid
    end

    it "should not report errors on .homophones" do
      set.should have(0).errors_on(:homophones)
    end
  end
end

describe HomophoneSet, '#fill_empty_homophones(n)' do
  it "builds homophones up to number given when there are 0" do
    set = HomophoneSet.new
    set.fill_empty_homophones 8
    set.should have(8).homophones
  end

  it "builds homophones up to number given when there are already 2" do
    set = HomophoneSet.new
    2.times { set.homophones.build }
    set.fill_empty_homophones 8
    set.should have(8).homophones
  end
end

describe HomophoneSet, "#homophones_sorted" do
  it "is ordered by name ascending" do
    set = HomophoneSet.new
    %w(erl earl url).each {|name| set.homophones.build :name => name }
    set.homophones_sorted.map(&:name).should == %w(earl erl url)
  end

  it "is case-inensitive" do
    set = HomophoneSet.new
    %w(erl earl URL).each {|name| set.homophones.build :name => name }
    set.homophones_sorted.map(&:name).should == %w(earl erl URL)
  end
end

describe HomophoneSet, 'comparable' do
  it "is comparable according to its first homophone" do
    smaller = HomophoneSet.new
    smaller.homophones.build :name => 'a'
    bigger = HomophoneSet.new
    bigger.homophones.build :name => 'zoo'
    smaller.should < bigger
  end

  it "does not rely on the homophones being previously sorted" do
    smaller = HomophoneSet.new
    smaller.homophones.build :name => 'eh'
    smaller.homophones.build :name => 'a'
    bigger = HomophoneSet.new
    bigger.homophones.build :name => 'ba'
    bigger.homophones.build :name => 'bah'
    smaller.should < bigger    
  end
end
