module AdminHelper
  def active_admin_item_class(item = 'dashboard')
    request.url.include?("admin/#{item}") ? 'active' : 'not-active'
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

  def deployment_status_to_level(status)
    status_to_level(status)
  end

  def status_to_level(status)
    case status
    when 'success'
      'success'
    when 'succeed'
      'success'
    when 'failed'
      'danger'
    else
      ''
    end
  end

  def date_list_to_hash(items)
    result = {}

    items.each do |item|
      result[item['date']] = item['value']
    end

    result
  end

  def format_string_date(datetime_s)
    if datetime_s
      d = DateTime.parse(datetime_s)

      d.strftime("%Y-%m-%d %H:%M:%S %Z")
    else
      ""
    end
  rescue e
    ""
  end

  def open_source_visibility_class(website)
    website.present? && website.account_type == 'open_source' ? '' : 'd-none'
  end

  def event_style(title)
    color = "#e5f7ff"

    danger_titles = [
      "instance-stop", "Destroy storage",
      "remove-storage-area", "delete-addon"
    ]
    warn_titles = %w[instance-restart instance-reload]

    color = "#ffe5e5" if danger_titles.include?(title)
    color = "#fdfdcf" if warn_titles.include?(title)

    "background-color: #{color}"
  end
end
