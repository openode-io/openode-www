require 'rest-client'

class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  helper_method :current_user

  def current_user
    if session[:token]
      @current_user ||= {
        name: 'what',
        token: session[:token]
      }
    else
      @current_user = nil
    end
  end

  def api(method, path = "/", args = {})
    headers = {
      "x-auth-token": current_user ? current_user[:token] : nil,
      "params": args[:params] || {}
    }

    url = "#{Rails.configuration.API_URL}#{path}"

    JSON.parse(RestClient::Request.execute(method: method,
                                           url: url,
                                           timeout: 10,
                                           payload: args[:payload],
                                           headers: headers))
  end
end
