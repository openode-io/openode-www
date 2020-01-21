module AdminHelper
  def active_admin_item_class(item = 'dashboard')
    params[:action] == item ? 'active' : 'not-active'
  end
end
