Given /^we have a homophone set "([^\"]*)"$/ do |phone_set|
  HOM_LIST = [phone_set.split(',').map {|hom| OpenStruct.new(:name => hom.strip, :definition => "")}]
end

Then /^I should see a link called "([^\"]*)"$/ do |link_content|
  response.should have_tag("a", link_content)
end

Then /^I should not see a link called "([^\"]*)"$/ do |link_content|
  response.should_not have_tag("a", link_content)
end
