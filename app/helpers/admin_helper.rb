module AdminHelper
  def active_admin_item_class(item = 'dashboard')
    params[:controller] == "admin/#{item}" ? 'active' : 'not-active'
  end
end
