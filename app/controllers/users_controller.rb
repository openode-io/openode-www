class UsersController < ApplicationController
  include Recaptchable

  def register; end

  def create
    if verify_recaptchas('register')
      response = api(:post, '/account/register', payload: user_params)

      json(response)
    else
      render :register, alert: "We need to verify that you are a human :)"
    end
  end

  def forgot_password; end

  def process_forgot_password; end

  def activate; end

  private

  def user_params
    params.require(:account).permit(:email, :password,
                                    :password_confirmation, :newsletter)
  end
end
