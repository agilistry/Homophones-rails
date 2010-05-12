Given /^we have a homophone set "([^\"]*)"$/ do |phone_set|
  HOM_LIST = [phone_set.split(',').map {|hom| OpenStruct.new(:name => hom.strip, :definition => "")}]
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

Given /^the administrator user name is "(.*)" with password "(.*)"$/ do |username, password|
  Login.create! :user_name => username, :password => password
end

When /^I log in with "(.*)" \/ "(.*)"$/ do |username, password|
  When %(I fill in "User Name" with "#{username}")
  When %(I fill in "Password" with "#{password}")
  When %(I press "Login")
end

When /^I create a homophone set with the following words:$/ do |table|
  When %(I go to the new homophone set page)
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

Then /^the homophones are in order: "(.*)"$/ do |homophones_list|
  homophone_names = homophones_list.split(',').map(&:strip)
  homophone_sets = Nokogiri.parse(response.body) / '.homophone_set'
  target_set = homophone_sets.detect do |set|
    homophone_names.all? {|name| set / ".homophone .name[text=#{name}]" }
  end
  homophone_div_names = (target_set / '.homophone .name').map(&:inner_text)
  homophone_div_names.should == homophone_names
end

Then /^each word has a definition$/ do
  definition_divs = Nokogiri.parse(response.body) / '.homophone_set .homophone .definition'
  definition_divs.should_not be_empty
  definition_divs.each {|definition| definition.inner_text.should be_present }
end
