class UsersController < ApplicationController
  include Recaptchable

  def register; end

  def create
    if verify_recaptchas('register')
      response = api(:post, '/account/register', payload: { account: user_params })

      set_token(response['token'])

      # TODO: - redirect to dashboard
      redirect_to root_url, notice: "Registered successfully!"
    else
      render :register, alert: "We need to verify that you are a human :)"
    end
  end

  def forgot_password; end

  def verify_reset_token
    reset_token = params['reset_token']
    result = api(
      :post, '/account/verify-reset-token',
      payload: { reset_token: reset_token }
    )

    set_token(result['token'])

    # TODO: - redirect to change password page
    redirect_to root_url, notice: "Valid reset token!"
  end

  def process_forgot_password
    email = params['email']

    api(:post, '/account/forgot-password', payload: { email: email })

    flash[:notice] = 'Done! If the email exists you will receive a reset token via email.'
    redirect_to action: :forgot_password
  end

  def activate; end

  private

  def user_params
    params.require(:account).permit(:email, :password,
                                    :password_confirmation, :newsletter)
  end
end
