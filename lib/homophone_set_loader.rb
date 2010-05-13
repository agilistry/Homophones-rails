class HomophoneSetLoader
  attr_accessor :raw_sets
  
  def load_raw_contents(filename)
    file = File.join(Rails.root, filename);
    raw_contents = File.read(file)
  end

  def create_homsets_from_json_string(raw_contents)
    return [] if raw_contents.blank?
    
    contents = JSON.load(raw_contents)
    homsets = contents[:HOMLIST]
    return [] unless homsets
    
    hs = {}
    raw_sets = homsets.each do |list|
      phones = list["PHONES"]
      next if phones.blank?
   
      key = phones.collect{|i| i["KEY"]}.sort.join("-")

      if !hs.has_key? key
        hs[key] =  phones.collect{|phone| {:name => phone['KEY'], :definition => phone['DEF']} }
      else
        p key
      end
    end
    hs
  end
  
  def has_homlist?(contents)
    
  end
  

  def load_from_file(filename)
    raw_contents = load_raw_contents(filename)
    @raw_sets = create_homsets_from_json(raw_contents)
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
