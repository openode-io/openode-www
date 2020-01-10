require 'rest-client'

class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  helper_method :current_user

  def current_user
    if session[:token]
      @current_user ||= {
        token: session[:token]
      }
    else
      @current_user = nil
    end
  end

  def set_token(token)
    session[:token] = token
  end

  def api(method, path = "/", args = {})
    headers = {
      "x-auth-token": session[:token],
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
