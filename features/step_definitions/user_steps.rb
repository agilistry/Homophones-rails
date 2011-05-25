Given /^I am not logged in$/ do
  visit destroy_user_session_path
end

Given /^I am not logged in as an admin$/ do
  visit admin_logout_path
end

module AdminCreationMethods
  def admin_with(username, password)
    Login.create!(:user_name => username, :password => password) unless Login.find_by_user_name(username)
  end
  
  def admin_login(username, password)
    visit admin_login_path
    fill_in 'User name', :with => username
    fill_in 'Password', :with => password
    click_button 'Login'    
  end
end
World(AdminCreationMethods)

When /^I log in as admin$/ do
  admin_with  'alan', 'supersecret'
  admin_login 'alan', 'supersecret'
end

When /^I log in as admin with wrong credentials$/ do
  admin_with  'alan', 'supersecret'
  admin_login 'alan', 'badbadbad'
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