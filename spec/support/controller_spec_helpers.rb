module ControllerSpecHelpers
  def stub_admin_logged_in(logged_in=true)
    before(:each) do
      controller.stub(:admin_logged_in?).and_return logged_in
    end
  end
end

RSpec.configure do |config| 
  config.extend ControllerSpecHelpers, :type => :controller
end
