module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  def self.stringify_rest_exception(exception)
    case exception.http_code
    when 401
      "Invalid credentials"
    else
      JSON.parse(exception.http_body)["error"] || exception.message
    end
  end

  included do
    # rescue_from RestClient::InternalServerError do |e|
    #  puts "internal errorrrrrrrrrrrr"
    # end

    rescue_from RestClient::Exception do |e|
      case request.format
      when "text/html"
        flash[:error] = ExceptionHandler.stringify_rest_exception(e)
        redirect_back fallback_location: root_path
      when "text/json"
        json({ error: ExceptionHandler.stringify_rest_exception(e) }, e.http_code)
      else
        json({ error: ExceptionHandler.stringify_rest_exception(e) }, e.http_code)
      end
    end
  end
end
