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


Given /^there are no homophone sets$/ do
  HomophoneSet.destroy_all
end

Then /^I should see a link called "([^\"]*)"$/ do |link_content|
  response.should have_tag("a", link_content)
end

Then /^I should not see a link called "([^\"]*)"$/ do |link_content|
  response.should_not have_tag("a", link_content)
end

Given /^I am not logged in$/ do
  
end

Given /^I am logged in$/ do
  Given "the administrator user name is \"something\" with password \"other\""
  When "I am on the admin login page"
  When "I fill in \"User name\" with \"something\""
  When "I fill in \"Password\" with \"other\""
  When "I press \"Login\""
end

Given /^the administrator user name is "(.*)" with password "(.*)"$/ do |username, password|
  Login.create! :user_name => username, :password => password
end

When /^I log in with "(.*)" \/ "(.*)"$/ do |username, password|
  visit login_path
  When %(I fill in "User Name" with "#{username}")
  When %(I fill in "Password" with "#{password}")
  When %(I press "Login")
end

Given /^I am logged in as "(.*)"$/ do |admin_name|
  Given %(the administrator user name is "#{admin_name}" with password "password")
  When %(I log in with "#{admin_name}" / "password")
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

Then /^I see (\d+) sets? of (\d+) homophones$/ do |num_sets, num_phones_in_set|
  response.should have_tag('.homophone_set', :count => num_sets.to_i) do
    with_tag('.homophone', :count => num_phones_in_set.to_i)
  end
end

Then /^the homophone sets are in order:$/ do |table|
  expected_homophone_sets = table.hashes.map {|hash|
    hash['homophones'].split(',').map(&:strip)
  }
  homophone_set_divs = Nokogiri.parse(response.body) / '.homophone_set'
  actual_homophone_sets = homophone_set_divs.map {|homophone_set_div|
    (homophone_set_div / '.homophone .name').map(&:inner_text)
  }
  actual_homophone_sets.should == expected_homophone_sets
end

Then /^the homophones are in order: "(.*)"$/ do |homophones_list|
  homophone_names = homophones_list.split(',').map(&:strip)
  homophone_sets = Nokogiri.parse(response.body) / '.homophone_set'
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
  homophone_group_letters = (Nokogiri.parse(response.body) / '.key_letter').map(&:inner_text)
  homophone_group_letters.should == homophone_group_letters.sort
end

Then /^each word has a definition$/ do
  definition_divs = Nokogiri.parse(response.body) / '.homophone_set .homophone .definition'
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
  response.should have_tag "div.homophone_set" do
    have_tag "span", homophone, :class => "name"
  end
end
