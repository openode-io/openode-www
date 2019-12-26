# frozen_string_literal: true

module ApplicationHelper

  def title
    if content_for?(:title)
      content_for :title
    else
      t("#{ controller_path.tr('/', '.') }.#{ action_name }.title", default: :site_name)
    end
  end

end