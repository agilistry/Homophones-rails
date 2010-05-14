class HomophoneSetLoader
  attr_accessor :raw_sets
  
  def load_raw_contents(file)
    raw_contents = File.read(file)
  end

  def create_homsets_from_json_string(raw_contents)
    hs = {}

    return hs if raw_contents.blank?

    contents = JSON.load(raw_contents)
   
    return hs unless contents['HOMLIST']
    
    raw_sets = contents['HOMLIST'].each do |list|
      phones = list['PHONES']
      next if phones.blank?
   
      key = phones.collect{|i| i['KEY']}.sort.join("-")

      unless hs.has_key?(key)
        hs[key] =  phones.collect{|phone| {:name => phone['KEY'], :definition => phone['DEF']} }
      end
    end
    hs 
  end

  def load_from_file(file)
    raw_contents = load_raw_contents(file)
    @raw_sets = create_homsets_from_json_string(raw_contents)
  end

  def save
    @raw_sets.each do |key, phones|
      HomophoneSet.transaction do
        hs = HomophoneSet.new
        phones.each do |phone|
          hs.homophones << Homophone.new(phone)
        end
        hs.save!
      end
    end  
  end

end
