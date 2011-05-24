Given /^I am not authenticated$/ do
  visit('/users/sign_out')
end

Given /^I am authenticated$/ do
  @iam = create_confirmed_user({:email => "me@example.com", :password => "password"})
  Then %[I can log in with "me@example.com" / "password"]
end

Given /^users:$/ do |table|
  table.hashes.each do |options|
    user = create_confirmed_user(options)
  end
end

Given /^unconfirmed users:$/ do |table|
  table.hashes.each do |options|
    user = create_unconfirmed_user(options)
  end
end

When /^I sign up with:$/ do |table|
  Given "I am on the Registration page"
  user_attributes = table.hashes.first
  user_attributes.each do |field_name, value|
    fill_in field_name, :with => value
  end
  fill_in 'Password confirmation', :with => user_attributes['Password']
  click_button 'Sign up'
  @signed_up_email = user_attributes['Email']
end

When /^I log in with$/ do |email, password|
  visit new_user_session_path
  fill_in :user_email, :with => email
  fill_in :user_password, :with => password
  click_button "Sign In"
end


