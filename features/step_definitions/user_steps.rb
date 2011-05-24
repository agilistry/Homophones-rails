Given /^I am not logged in$/ do
  visit destroy_user_session_path
end

Given /^I am not logged in as an admin$/ do
  visit admin_logout_path
end

When /^I log in as admin$/ do
  Login.create!(:user_name => 'alan', :password => 'supersecret') unless Login.find_by_user_name('alan')
  visit admin_login_path
  fill_in 'User name', :with => 'alan'
  fill_in 'Password', :with => 'supersecret'
  click_button 'Login'
end

When /^I log in as admin with wrong credentials$/ do
  Login.create!(:user_name => 'alan', :password => 'supersecret') unless Login.find_by_user_name('alan')
  visit admin_login_path
  fill_in 'User name', :with => 'alan'
  fill_in 'Password', :with => 'this is bad'
  click_button 'Login'
end

When /^I log in with "(.*)" \/ "(.*)"$/ do |email, password|
  visit new_user_session_path
  When %(I fill in "Email" with "#{email}")
  When %(I fill in "Password" with "#{password}")
  When %(I press "Login")
end

When /^I should be logged in as "([^"]*)"$/ do |email|
  page.find('span.logged_in_user').tap do |span|
    span.should be_present
    span.text.should == email
  end
end