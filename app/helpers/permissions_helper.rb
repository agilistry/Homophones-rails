module PermissionsHelper
  def can_edit_homsets?
    current_user && current_user.admin?
  end
end
