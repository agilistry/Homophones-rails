# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
HomophoneSet.transaction do
  hom_list = JSON.load(File.read(File.join(Rails.root, "homlist.txt")))['HOMLIST'].
    map {|list| list['PHONES']}.compact.
    each do |homset|
      hs = HomophoneSet.new
      homset.each do |hom|
        hs.homophones << Homophone.create(:name => hom['KEY'], :definition => hom['DEF'])
      end
      hs.save!
    end
end
