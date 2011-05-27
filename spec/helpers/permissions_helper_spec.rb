require "spec_helper"

class PermissableSpecObject
  include PermissionsHelper
end

describe PermissionsHelper do
  describe "#can_edit_homsets?" do
    before do
      @permissable = PermissableSpecObject.new
    end

    it "returns false if there is no current user" do
      @permissable.should_receive(:current_user).and_return(nil)
      @permissable.can_edit_homsets?.should be_false
    end

    it "returns false if the current user is not admin" do
      @permissable.should_receive(:current_user).any_number_of_times.and_return(stub(:admin? => false))
      @permissable.can_edit_homsets?.should be_false
    end

    it "returns true if the current user is an admin" do
      @permissable.should_receive(:current_user).any_number_of_times.and_return(stub(:admin? => true))
      @permissable.can_edit_homsets?.should be_true
    end
  end
end
