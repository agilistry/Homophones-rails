require 'spec_helper'

describe HomophoneSet, 'validations' do
  it "is invalid with 0 homophones" do
    set = HomophoneSet.new
    set.should_not be_valid
    set.should have_at_least(1).error_on(:base)
  end

  it "is valid with 2 homophones" do
    set = HomophoneSet.new
    set.homophones.build :name => 'asdfg'
    set.homophones.build :name => 'asdf'
    set.should be_valid
  end

  it "is valid with 2 homographs" do
    set = HomophoneSet.new
    2.times { set.homophones.build :name => 'asdf' }
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

describe "HomophoneSet", "can be created" do
  it "from a list of words" do
    words = %w(ba bah)
    homophone_set = HomophoneSet.new(:from => words)
    words.each do |word|
      homophone_set.homophones.map(&:name).should include(word)
    end
  end
  it "from a single word" do
    homophone_set = HomophoneSet.new(:from => 'foo')
    homophone_set.homophones.first.name.should == 'foo'
  end
end

describe HomophoneSet, 'comparable' do
  it "is comparable according to its first homophone" do
    smaller = HomophoneSet.new(:from => 'a')
    bigger = HomophoneSet.new(:from => 'zoo')
    [bigger, smaller].sort.should == [smaller, bigger]
  end

  it "does not rely on the homophones being previously sorted" do
    smaller = HomophoneSet.new(:from => %w(eh a))
    bigger = HomophoneSet.new(:from => %w(ba bah))
    [bigger, smaller].sort.should == [smaller, bigger]
  end
end

describe HomophoneSet, 'sorting and grouping' do
  it "indexes by the 1st letter of the 1st alphabetical word in the list" do
    set = HomophoneSet.new(:from => %w(ewe you Yew))
    set.index_letter.should == "e"
  end
  
  it "downcases the index letter" do
    set = HomophoneSet.new(:from => %w(xa Bah ma))
    set.index_letter.should == "b"
  end
  
  it "can handle punctuation" do
    set = HomophoneSet.new(:from => %w('cause caws))
    set.index_letter.should == "c"
  end
end
