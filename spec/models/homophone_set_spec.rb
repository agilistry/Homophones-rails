require 'spec_helper'

describe HomophoneSet, 'validations' do
  it "is invalid with 0 homophones" do
    set = HomophoneSet.new
    set.should_not be_valid
    set.should have_at_least(1).error_on(:base)
  end

  it "is valid with 2 homophones" do
    set = HomophoneSet.new
    2.times { set.homophones.build }
    set.should be_valid
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
