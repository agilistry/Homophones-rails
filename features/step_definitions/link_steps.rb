module LinkHelpers
  def links_with_text(link_content)
    page.all('a').select {|e| e.text == link_content }
  end
end
World(LinkHelpers)

Then /^I should see a link called "([^\"]*)"$/ do |link_content|
  links_with_text(link_content).should have(1).item
end

Then /^I should not see a link called "([^\"]*)"$/ do |link_content|
  links_with_text(link_content).should be_empty
end