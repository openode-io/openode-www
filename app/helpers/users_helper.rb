module UsersHelper
  def render_recaptcha(action, show_recaptcha_v2)
    return if Rails.env.test?

    if show_recaptcha_v2
      recaptcha_tags(
        site_key: Rails.application.credentials.recaptcha_v2[:site_key]
      )
    else
      recaptcha_v3(
        action: action,
        site_key: Rails.application.credentials.recaptcha_v3[:site_key]
      )
    end
  end
end
