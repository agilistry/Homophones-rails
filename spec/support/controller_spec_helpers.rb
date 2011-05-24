module ControllerSpecHelpers
  def stub_admin_logged_in(logged_in=true)
    before(:each) do
      controller.stub(:admin_logged_in?).and_return logged_in
    end
    stub_devise_logged_out
  end
  
  def stub_devise_logged_out
    before { controller.stub(:warden).and_return stub('warden is stupid').as_null_object }
  end
end

RSpec.configure do |config| 
  config.extend ControllerSpecHelpers, :type => :controller
end
