class HomophoneSetLoader
  attr_accessor :raw_sets
  
  def load_raw_contents(filename)
    file = File.join(Rails.root, filename);
    raw_contents = File.read(file)
  end

  def create_homsets_from_json(raw_contents)
    contents = JSON.load(raw_contents)
    hs = {}
    raw_sets = contents['HOMLIST'].each do |list|
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
