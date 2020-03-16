module Recaptchable
  extend ActiveSupport::Concern

  included do
    def verify_recaptchas(action, score = 0.5)
      raise 'Action needed to process recaptcha' if action.blank?
      return true if Rails.env.test?

      v2_secret_key = ENV['RECAPTCHA_V2_SECRET_KEY']
      v3_secret_key = ENV['RECAPTCHA_V3_SECRET_KEY']

      success = verify_recaptcha(
        action: action,
        minimum_score: score,
        secret_key: v3_secret_key
      )

      unless success
        checkbox_success = verify_recaptcha(secret_key: v2_secret_key)
      end

      @show_recaptcha_v2 = true # !success

      (success || checkbox_success)
    end
  end
end
