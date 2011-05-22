# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
#require 'spec/autorun'
require 'rspec/rails'
require File.join(RAILS_ROOT, 'spec/fixjour_builders.rb')
require 'webrat'
require 'webrat/core/matchers'

# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = Rails.root.to_s + '/spec/fixtures/'
  config.include Webrat::Matchers, :type => :views
  
  
  module ControllerSpecHelpers
    def stub_logged_in(logged_in=true)
      before(:each) do
        controller.stub(:logged_in?).and_return logged_in
      end
    end
  end
  config.extend ControllerSpecHelpers, :type => :controller
end
