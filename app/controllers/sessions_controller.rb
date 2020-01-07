class SessionsController < ApplicationController
  def new
    # -
  end

  def create
    payload = { email: params[:email], password: params[:password] }

    token = api(:post, '/account/getToken', payload: payload)

    session[:token] = token

    redirect_to root_url, success: "Logged in!"
  end

  def destroy
    session[:token] = nil

    redirect_to root_url, success: "Logged out!"
  end
end
