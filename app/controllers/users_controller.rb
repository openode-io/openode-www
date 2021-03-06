class UsersController < ApplicationController
  include Recaptchable

  def register; end

  def create
    if verify_recaptchas('register')
      response = api(:post, '/account/register', payload: { account: user_params })
      user = api(:get, '/account/me', token: response['token'])

      set_session(response['token'], user)

      redirect_to({ controller: 'admin/instances' }, notice: "Registered successfully!")
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
    user = api(:get, '/account/me', token: result['token'])

    set_session(result['token'], user)

    # TODO: - redirect to change password page
    redirect_to root_url, notice: "Valid reset token!"
  end

  def process_forgot_password
    email = params['email']

    api(:post, '/account/forgot-password', payload: { email: email })

    flash[:notice] = 'Done! If the email exists you will receive a reset token via email.'
    redirect_to action: :forgot_password
  end

  def activate
    api(:post, "/account/activate/#{params['user_id']}/#{params['activation_token']}")

    flash[:notice] = "Your account activated successfully, please login to get started!"
    redirect_to '/login'
  end

  private

  def user_params
    params.require(:account).permit(:email, :password,
                                    :password_confirmation, :newsletter)
  end
end
