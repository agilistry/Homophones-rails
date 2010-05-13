require 'spec_helper'

describe Homophone, 'comparable' do
  it "is comparable according to name" do
    Homophone.new(:name => 'a').should < Homophone.new(:name => 'eh')
  end

  it "is case-insensitive" do
    Homophone.new(:name => 'a').should < Homophone.new(:name => 'Alf')
  end
end
