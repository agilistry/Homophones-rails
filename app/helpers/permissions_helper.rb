module PermissionsHelper
  def can_edit_homsets?
    current_user && current_user.admin?
  end

  def may_add_homsets?
    can_edit_homsets?
  end
end
