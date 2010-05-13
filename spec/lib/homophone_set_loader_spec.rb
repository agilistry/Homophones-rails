require 'spec_helper'

describe HomophoneSetLoader do
  before(:each) do
    @loader = HomophoneSetLoader.new
  end
  
  def make_json_string(top_level_key)
    template = <<-EOD
                {
                  "#{top_level_key}": []
                  }
                EOD
  end

  def should_return_empty_homlist(input)
    loaded_homsets = @loader.create_homsets_from_json_string(input)
    loaded_homsets.length.should == 0
  end
  
  it "returns an empty homlist if JSON file is empty" do
    loaded_homsets = @loader.create_homsets_from_json_string("")
    loaded_homsets.length.should == 0
  end
  
  it "returns an empty homlist if JSON contains no homlist" do
    a_json_string_with_no_homlist = make_json_string("PUNKROCK")
    should_return_empty_homlist(a_json_string_with_no_homlist)
   end
   
   it "returns an empty homlist if JSON contains an empty homlist" do
     a_json_string_with_an_empty_homlist = make_json_string("HOMLIST")
     should_return_empty_homlist(a_json_string_with_an_empty_homlist)
    end
end
