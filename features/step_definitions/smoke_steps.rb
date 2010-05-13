require 'mechanize'

Given /^the secret admin credentials$/ do
  credentials = YAML.load File.read(File.join(Rails.root, 'config/admin_credentials.yml'))
  login = credentials['login']
  raise "No key 'login' found" if login.blank?
  @admin_username = login.fetch 'username'
  raise "No key 'username' found" if @admin_username.blank?
  @admin_password = login.fetch 'password'
  raise "No key 'password' found" if @admin_password.blank?
end

When /^I log in with the secret admin credentials$/ do
  # http = Net::HTTP.new 'http://homophones.heroku.com'
  # query = "user_name=#{@admin_username}&password=#{@admin_password}"
  # response = http.post('/admin/login', query)
  # query = "user_name=#{@admin_username}&password=#{@admin_password}"
  # response = Net::HTTP.post_form(URI.parse('http://homophones.heroku.com/admin/login'), 
  #                                {:login_user_name => @admin_username,
  #                                  :login_password => @admin_password,
  #                                  :commit => "Login"})
  # 
  # p response
  # 
  agent = Mechanize.new
  page = agent.get 'http://homophones.heroku.com/admin/login'
  login_form = page.forms.first
  login_form['login[user_name]'] = @admin_username
  login_form['login[password]'] = @admin_password
  @response = login_form.submit
end

Then /^I should see "(.*)"$/ do |expected_text|
  @response.send(:html_body).should include(expected_text)
end
