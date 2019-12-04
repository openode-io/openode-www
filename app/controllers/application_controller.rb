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
    api_url = 'http://localhost:3000'

    headers = {
      "x-auth-token": current_user ? current_user[:token] : nil,
      "params": args[:params] || {}
    }

    url = "#{api_url}#{path}"

    JSON.parse(RestClient::Request.execute(method: method,
                                           url: url,
                                           timeout: 10,
                                           payload: args[:payload],
                                           headers: headers))
  end
end
