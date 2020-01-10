module UsersHelper
  def render_recaptcha(action, show_recaptcha_v2)
    return if Rails.env.test?

    if show_recaptcha_v2
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
