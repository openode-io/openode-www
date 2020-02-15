class SessionsController < ApplicationController
  include Recaptchable

  def new
    # -
  end

  def create
    payload = { email: params[:email], password: params[:password] }

    token = api(:post, '/account/getToken', payload: payload)

    if verify_recaptchas('login') && token.present?
      user = api(:get, "/account/me", token: token)
      set_session(token, user)
      redirect_to({ controller: 'admin/instances' }, notice: "Logged in!")
    else
      render :new, error: "reCaptcha or Token are invalid. Please try again."
    end
  end

  def destroy
    set_session(nil, nil)

    redirect_to root_url, notice: "Logged out!"
  end
end
