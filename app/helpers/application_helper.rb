# frozen_string_literal: true

module ApplicationHelper
  def title
    if content_for?(:title)
      content_for :title
    else
      t("#{controller_path.tr('/', '.')}.#{action_name}.title", default: :site_name)
    end
  end

  def flash_bootstrap(level)
    level = 'notice' if level.blank?

    case level
    when 'warning' then "alert alert-warning"
    when /success|ok|notice/ then "alert alert-success auto-close"
    when /error|alert/ then "alert alert-danger"
    end
  end
end
