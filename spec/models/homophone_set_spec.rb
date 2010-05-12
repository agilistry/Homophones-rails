require 'spec_helper'

describe HomophoneSet do
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
