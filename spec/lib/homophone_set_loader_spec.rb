require 'spec_helper'

describe HomophoneSetLoader do
  it "ignores duplicate when loading from file" do
    input = <<-EOD
    {
    "HOMLIST":
    [
      {
        "PHONES":
        [
          {
          "KEY":"a",
          "DEF":"short little word"
          },
          {
          "KEY":"eh",
          "DEF":"interrogative"
          }
        ]
      },
      {
        "PHONES":
        [
          {
          "KEY":"a",
          "DEF":"things done"
          },
          {
          "KEY":"eh",
          "DEF":"chopping tool"
          }
        ]
      }
     ]
    }
    EOD
    
    filename = 'testlist.txt'
    filepath = File.join(Rails.root, filename);
    File.open(filepath, 'w') {|f| f.write(input) }
  
    loader = HomophoneSetLoader.new
    loaded_homsets = loader.load_from_file filename
    File.delete(filepath)
    loaded_homsets.length.should == 1
  end
  
  def add_phone_to(set, key, definition)
    set << {:KEY => key, :DEF => definition}
  end
  
  def add_phone_set_to(hom_set, phone_set)
    hom_set << {:PHONES => phone_set}
  end
  
  it "loads a single phoneset" do
    loader = HomophoneSetLoader.new

    phone_set = []
    hom_set = []
    
    add_phone_to(phone_set, "a", "a little word")
    add_phone_to(phone_set, "eh", "interrogative")
    add_phone_set_to(hom_set, phone_set)
    
    input = {:HOMLIST => hom_set}.to_json
    loaded_homsets = loader.create_homsets_from_json_string(input)
    loaded_homsets.length.should == 1
  end
  
  it "loads multiple phonesets" do
    loader = HomophoneSetLoader.new
    phone_set = []
    hom_set = []
    
    add_phone_to(phone_set, "a", "a little word")
    add_phone_to(phone_set, "eh", "interrogative")
    add_phone_set_to(hom_set, phone_set)
    
    phone_set = []
    add_phone_to(phone_set, "b", "a letter")
    add_phone_to(phone_set, "bee", "makes honey")
    add_phone_set_to(hom_set, phone_set)
 
    input = {:HOMLIST => hom_set}.to_json
    loaded_homsets = loader.create_homsets_from_json_string(input)
    loaded_homsets.length.should == 2
  end
  
end
# describe HomophoneSetLoader, "returns an empty homlist" do
# 
#   def should_return_empty_homlist(input)
#     loader = HomophoneSetLoader.new
#     loaded_homsets = loader.create_homsets_from_json_string(input)
#     loaded_homsets.length.should == 0
#   end
# 
#   it "if JSON string is empty" do
#     should_return_empty_homlist("")
#   end
# 
#   it "if JSON contains no homlist" do
#     input = {:PUNKROCK => []}.to_json
#     should_return_empty_homlist(input)
#   end
# 
#   it "if JSON contains an empty homlist" do
#     input = {:HOMLIST => []}.to_json
#     should_return_empty_homlist(input)
#   end
# 
#   it "if JSON contains no homsets" do
#     input = {:HOMLIST => [{}]}.to_json
#     should_return_empty_homlist(input)
#   end
# 
#   it "if JSON contains only empty homsets" do
#     input = {:HOMLIST => [{:PHONES => []}]}.to_json
#     should_return_empty_homlist(input)
#   end
# 
# end

# describe HomophoneSetLoader do
#   it "happy path" do
#     phone_set = []
#     phone_set << {:KEY => "a", :DEF => "a short little word"}
#     phone_set << {:KEY => "eh", :DEF => "interrogative"}
#     hom_set = []
#     hom_set << {:PHONES => phone_set}
#     
#     phone_set = []
#     phone_set << {:KEY => "b", :DEF => "a letter"}
#     phone_set << {:KEY => "bee", :DEF => "makes honey"}
#     hom_set << {:PHONES => phone_set}
#     
#     input = {:HOMLIST => hom_set}.to_json
#     
#     puts input
#     
#     loader = HomophoneSetLoader.new
#     loaded_homsets = loader.create_homsets_from_json_string(input)
#     
#     # expected_homsets = [
#     #     {:key => "a", :def => "a short little word"},
#     #     {:key => "eh", :def => "interrogative"}
#     #     ]
#     #   loaded_homsets.should == expected_homsets
#   end
# end