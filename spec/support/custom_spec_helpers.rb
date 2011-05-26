module ControllerSpecHelpers
  def stub_devise_logged_out
    before { controller.stub(:warden).and_return stub('warden is stupid').as_null_object }
  end
end

module UserSpecHelpers
  def new_admin_user(properties={})
    new_user(properties).tap {|user| user.admin = true }
  end

  def create_admin_user(properties={})
    new_admin_user(properties).tap {|user| user.save! }
  end
end

RSpec.configure do |config| 
  config.extend ControllerSpecHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :controller
  config.include UserSpecHelpers
end
