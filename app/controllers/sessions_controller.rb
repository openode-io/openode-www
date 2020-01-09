class SessionsController < ApplicationController
  include Recaptchable
  
  def new
    # -
  end

  def create
    payload = { email: params[:email], password: params[:password] }

    token = api(:post, '/account/getToken', payload: payload)

    if verify_recaptcha && token.present?
      session[:token] = token
      redirect_to root_url, notice: "Logged in!"
    else
      render :new, error: "reCaptcha or Token are invalid. Please try again."
    end
  end

  def destroy
    session[:token] = nil

    redirect_to root_url, notice: "Logged out!"
  end
end
