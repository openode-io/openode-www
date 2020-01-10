module Recaptchable
  extend ActiveSupport::Concern

  included do
    def verify_recaptchas
      return true if Rails.env.test?

      v2_secret_key = ENV['RECAPTCHA_V2_SECRET_KEY']
      v3_secret_key = ENV['RECAPTCHA_V3_SECRET_KEY']

      success = verify_recaptcha(
        action: params[:action],
        minimum_score: 0.5,
        secret_key: v3_secret_key
      )

      unless success
        checkbox_success = verify_recaptcha(secret_key: v2_secret_key)
      end

      @show_recaptcha_v2 = !success

      (success || checkbox_success)
    end
  end
end
