Given /^we have a homophone set:$/ do |table|
  homophone_set = HomophoneSet.new
  table.hashes.each do |phone_attrs|
    homophone_set.homophones.build phone_attrs
  end
  homophone_set.save!
end

Given /^I have the quiz question:$/ do |table|
  table.hashes.each do |question_attrs|
    Question.create! question_attrs 
  end
end

Then /^I see the quiz questions:$/ do |table|
  expected_questions = table.hashes.map {|hash| 
    hash['question_text']
  }
  actual_questions = (Nokogiri.parse(page.body) / '.question_text').map(&:inner_text)
  actual_questions.should == expected_questions
end

Given /^there are no homophone sets$/ do
  HomophoneSet.destroy_all
end

When /^I create a homophone set with the following words:$/ do |table|
  When %(I go to the new homophone set page)
  table.hashes.each_with_index do |phone_attrs, i|
    fill_in "homophone_set[homophones][#{i}][name]", :with => phone_attrs['name']
    fill_in "homophone_set[homophones][#{i}][definition]", :with => phone_attrs['definition']
  end
  click_button "Publish"
end

When /^I edit the homophone set containing "(.*)" to be:$/ do |phone_name, table|
  homophone_set = HomophoneSet.find Homophone.find_by_name!(phone_name).homophone_set_id
  visit edit_admin_homophone_set_path(homophone_set)
  table.hashes.each_with_index do |phone_attrs, i|
    fill_in "homophone_set[homophones][#{i}][name]", :with => phone_attrs['name']
    fill_in "homophone_set[homophones][#{i}][definition]", :with => phone_attrs['definition']
  end   
  click_button "Publish"
end

Then /^I see (\d+) sets? of (\d+) homophones each$/ do |num_sets, num_phones_in_set|
  sets = page.all(".homophone_set")
  sets.should have(num_sets.to_i).items
  sets.each {|s| s.all('.homophone').should have(num_phones_in_set.to_i).items }
end

Then /^the homophone sets are in order:$/ do |table|
  expected_homophone_sets = table.hashes.map {|hash|
    hash['homophones'].split(',').map(&:strip)
  }
  homophone_set_divs = Nokogiri.parse(page.body) / '.homophone_set'
  actual_homophone_sets = homophone_set_divs.map {|homophone_set_div|
    (homophone_set_div / '.homophone .name').map(&:inner_text)
  }
  actual_homophone_sets.should == expected_homophone_sets
end

Then /^the homophones are in order: "(.*)"$/ do |homophones_list|
  homophone_names = homophones_list.split(',').map(&:strip)
  homophone_sets = Nokogiri.parse(page.body) / '.homophone_set'
  target_set = homophone_sets.detect do |set|
    homophone_names.all? {|name| set / ".homophone .name[text=\"#{name}\"]" }
  end
  homophone_div_names = (target_set / '.homophone .name').map(&:inner_text)
  homophone_div_names.should == homophone_names
end

Given /^I have the production data loaded$/ do
  load File.join(RAILS_ROOT, 'db/seeds.rb')
end

Then /^the homophone groups are in order$/ do
  homophone_group_letters = (Nokogiri.parse(page.body) / '.key_letter').map(&:inner_text)
  homophone_group_letters.should == homophone_group_letters.sort
end

Then /^each word has a definition$/ do
  definition_divs = Nokogiri.parse(page.body) / '.homophone_set .homophone .definition'
  definition_divs.should_not be_empty
  definition_divs.each {|definition| definition.inner_text.should be_present }
end

Then /^I see the error "(.*)"$/ do |error_message|
  Then %(I should see "#{error_message}")
end

Then /^there (?:is|are) (\d+) homophone sets?$/ do |num_sets|
  HomophoneSet.count.should == num_sets.to_i
end

Then /^I should see a homophone set that contains "([^\"]*)"$/ do |homophone|
  page.all('div.homophone_set span.name').map(&:text).should include(homophone)
end
