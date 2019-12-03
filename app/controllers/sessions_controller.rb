class SessionsController < ApplicationController
  def new
    # -
  end

  def create
    payload = { email: params[:email], password: params[:password] }

    result = api(:post, '/account/getToken', payload: payload)

    token = JSON.parse result.body

    session[:token] = token

    redirect_to root_url, notice: "Logged in!"
  end

  def destroy
    session[:token] = nil

    redirect_to root_url, notice: "Logged out!"
  end
end
