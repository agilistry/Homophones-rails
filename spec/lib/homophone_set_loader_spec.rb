require 'spec_helper'

describe HomophoneSetLoader, "returns an empty homlist" do

  def should_return_empty_homlist(input)
    loader = HomophoneSetLoader.new
    loaded_homsets = loader.create_homsets_from_json_string(input)
    loaded_homsets.length.should == 0
  end

  it "if JSON string is empty" do
    should_return_empty_homlist("")
  end

  it "if JSON contains no homlist" do
    input = {:PUNKROCK => []}.to_json
    should_return_empty_homlist(input)
  end

  it "if JSON contains an empty homlist" do
    input = {:HOMLIST => []}.to_json
    should_return_empty_homlist(input)
  end

  it "if JSON contains no homsets" do
    input = {:HOMLIST => [{}]}.to_json
    should_return_empty_homlist(input)
  end

  it "if JSON contains only empty homsets" do
    input = {:HOMLIST => [{:PHONES => []}]}.to_json
    should_return_empty_homlist(input)
  end

end
