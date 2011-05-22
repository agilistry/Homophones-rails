class HomophoneSetLoader
  attr_accessor :raw_sets
  
  def load_from_file(file)
    raw_contents = read_raw_contents(file)
    @raw_sets = translate_homlist_from_json_string(raw_contents)
  end

  def read_raw_contents(file)
    raw_contents = File.read(file)
  end

  def translate_homlist_from_json_string(raw_contents)
    transitional_homlist = create_transitional_homlist(raw_contents)
    create_homlist(transitional_homlist)
  end

  def create_transitional_homlist(raw_contents)
    return [] if raw_contents.blank?
    contents = JSON.load(raw_contents)
    transitional_homlist = contents['HOMLIST']
    return [] unless transitional_homlist
    transitional_homlist
  end

  def create_homlist(transitional_homlist)
    collected_homsets = {}
    transitional_homlist.each do |transitional_homset|
      collect_phones_into(collected_homsets, transitional_homset)
    end
    collected_homsets
  end

  def collect_phones_into(collector, transitional_homset)
    transitional_phones = transitional_homset['PHONES']
    return if transitional_phones.blank?

    key = create_key(transitional_phones)

    unless collector.has_key?(key)
      collector[key] = transitional_phones.collect do |transitional_phone|
        {:name => transitional_phone['KEY'], :definition => transitional_phone['DEF']}
      end
    end
  end

  def create_key(transitional_phones)
    transitional_phones.collect{|i| i['KEY']}.sort.join("-")
  end
  
  def save
    @raw_sets.each do |key, phones|
      HomophoneSet.transaction do
        homset = HomophoneSet.new
        phones.each do |phone|
          homset.homophones << Homophone.new(phone)
        end
        homset.save!
      end
    end  
  end

end
