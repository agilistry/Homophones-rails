Given /^I am not logged in$/ do
  visit destroy_user_session_path
end

Given /^the confirmed users?:$/ do |table|
  table.hashes.each do |user_hash|
    create_user user_hash.symbolize_keys
  end
end

module UserMethods
  def sign_in(email, password)
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    click_button 'Sign in'
  end
end
World(UserMethods)

When /^I log in as admin$/ do
  visit new_user_session_path
  create_admin_user :email => 'alan@cooper.com', :password => 'supersecret'
  sign_in 'alan@cooper.com', 'supersecret'
end

When /^I log in as admin with wrong credentials$/ do
  visit new_user_session_path
  create_admin_user :email => 'alan@cooper.com', :password => 'supersecret'
  sign_in 'alan@cooper.com', 'badbadbad'
end

When /^I log in with "(.*)" \/ "(.*)"$/ do |email, password|
  sign_in email, password
end

When /^I should be logged in as "([^"]*)"$/ do |email|
  page.find('span.logged_in_user').tap do |span|
    span.should be_present
    span.text.should == email
  end
end