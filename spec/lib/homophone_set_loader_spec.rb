require 'spec_helper'

describe HomophoneSetLoader, "loading from a file" do
  before(:each) do
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
    
    @filepath = File.join(Rails.root, 'testlist.txt');
    
    File.open(@filepath, 'w') {|f| f.write(input) }
  end

  after(:each) do
    File.delete(@filepath)
  end

  it "ignores duplicate" do  
    loader = HomophoneSetLoader.new
    loaded_homsets = loader.load_from_file @filepath
    loaded_homsets.length.should == 1
  end
end




describe HomophoneSetLoader, "yaya" do
  before(:each) do
    @loader = HomophoneSetLoader.new
    @homlist = []
  end
  
  def add_phone_to(set, key, definition)
    set << {:KEY => key, :DEF => definition}
  end
  
  def add_homset_to(list, set)
    list << {:PHONES => set}
  end
  
  it "loads a phone's key and definition" do
    homset = []
    add_phone_to(homset, "a", "a little word")
    add_phone_to(homset, "eh", "interrogative")
    add_homset_to(@homlist, homset)
 
    input = {:HOMLIST => @homlist}.to_json
    loaded_homsets = @loader.translate_homlist_from_json_string(input)
    
    output = {
      "a-eh" => [
      {:name => "a", :definition => "a little word"},
      {:name => "eh", :definition => "interrogative"}
      ]
    }
    loaded_homsets.should == output
  end
  
  it "retains only the first of multiple phone sets with the same keys" do
    homset = []
    add_phone_to(homset, "a", "a little word")
    add_phone_to(homset, "eh", "interrogative")
    add_homset_to(@homlist, homset)
      
    homset = []
    add_phone_to(homset, "a", "the indefinite article")
    add_phone_to(homset, "eh", "confirming Canadian")
    add_homset_to(@homlist, homset)
 
    input = {:HOMLIST => @homlist}.to_json

    loaded_homsets = @loader.translate_homlist_from_json_string(input)
    
    output = {
      "a-eh" => [
      {:name => "a", :definition => "a little word"},
      {:name => "eh", :definition => "interrogative"}
      ]
    }
    loaded_homsets.should == output
  end
  
  it "loads a single homset" do
    homset = []
    add_phone_to(homset, "a", "a little word")
    add_phone_to(homset, "eh", "interrogative")
    add_homset_to(@homlist, homset)
    
    input = {:HOMLIST => @homlist}.to_json
    loaded_homsets = @loader.translate_homlist_from_json_string(input)

    loaded_homsets.length.should == 1
  end
  
  it "loads multiple homsets" do
    homset = []
    add_phone_to(homset, "a", "a little word")
    add_phone_to(homset, "eh", "interrogative")
    add_homset_to(@homlist, homset)
    
    homset = []
    add_phone_to(homset, "b", "a letter")
    add_phone_to(homset, "bee", "makes honey")
    add_homset_to(@homlist, homset)
 
    input = {:HOMLIST => @homlist}.to_json
    loaded_homsets = @loader.translate_homlist_from_json_string(input)

    loaded_homsets.length.should == 2
  end
  
end




describe HomophoneSetLoader, "returns an empty homlist" do

  def should_return_empty_homlist(input)
    loader = HomophoneSetLoader.new
    loaded_homsets = loader.translate_homlist_from_json_string(input)
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
