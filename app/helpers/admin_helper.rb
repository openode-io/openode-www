module AdminHelper
  def active_admin_item_class(item = 'dashboard')
    params[:controller] == "admin/#{item}" ? 'active' : 'not-active'
  end

  def instance_to(instance_id)
    "/admin/instances/#{instance_id}/"
  end

  def instance_access_to(instance_id)
    "#{instance_to(instance_id)}access/"
  end

  def instance_settings_to(instance_id)
    "#{instance_to(instance_id)}settings/"
  end

  def account_to
    "/admin/account/"
  end
end
