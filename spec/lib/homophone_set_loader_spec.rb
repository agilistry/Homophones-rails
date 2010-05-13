require 'spec_helper'

describe HomophoneSetLoader do
  it "returns an empty homlist if JSON file is empty" do
    loader = HomophoneSetLoader.new
    loaded_homsets = loader.create_homsets_from_json_string("")
    loaded_homsets.length.should == 0
  end
  
  it "returns an empty homlist if JSON contains no homlist" do
     loader = HomophoneSetLoader.new
     input = <<-EOD
                {
                  "PUNKROCK": []
                  }
                EOD
     loaded_homsets = loader.create_homsets_from_json_string(input)
     loaded_homsets.length.should == 0
   end
   
end
