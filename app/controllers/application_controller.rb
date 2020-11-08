require 'rest-client'

class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  def msg(key)
    I18n.t key
  end

  helper_method :current_user

  def authenticate_user
    if current_user.blank?
      redirect_to '/', notice: "Not authorized!"
    end
  end

  def current_user
    if session[:token]

      @current_user ||= {
        token: session[:token],
        user_type: session[:user]['type']
      }

      @current_user
    else
      @current_user = nil
    end
  end

  def super_admin?
    @current_user && @current_user[:user_type] == "admin"
  end

  def set_session(token, user)
    session[:token] = token
    session[:user] = user
  end

  def api(method, path = "/", args = {})
    headers = {
      "x-auth-token": args[:token] || session[:token],
      "x-origin-request-ip": request.remote_ip,
      "params": args[:params] || {}
    }

    url = "#{Rails.configuration.API_URL}#{path}"

    payload = args[:payload] ? JSON.parse(args[:payload].to_json) : nil

    JSON.parse(RestClient::Request.execute(method: method,
                                           url: url,
                                           timeout: 10,
                                           payload: payload,
                                           headers: headers))
  end
end
