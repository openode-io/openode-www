module UsersHelper
  def render_recaptcha(action, _show_recaptcha_v2)
    return if Rails.env.test?

    # force captch v2
    show_v2 = true

    if show_v2
      recaptcha_tags(
        site_key: ENV['RECAPTCHA_V2_SITE_KEY']
      )
    else
      recaptcha_v3(
        action: action,
        site_key: ENV['RECAPTCHA_V3_SITE_KEY']
      )
    end
  end
end
