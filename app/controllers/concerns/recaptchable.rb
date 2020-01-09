module Recaptchable
  extend ActiveSupport::Concern
  
  included do
    def verify_recaptchas

      success = verify_recaptcha(action: params[:action], minimum_score: 0.5, secret_key: Rails.application.credentials.recaptcha_v3[:secret_key])
      checkbox_success = verify_recaptcha(secret_key:Rails.application.credentials.recaptcha_v2[:secret_key]) unless success
      @show_checkbox_recaptcha = !success
      
      (success || checkbox_success)
    end     
  end
end