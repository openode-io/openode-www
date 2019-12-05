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

  def handle_error_html(msg)
    logger.error("Hook (HTML) error handling, msg = #{msg}")
    flash[:error] = msg
    redirect_back fallback_location: root_path
  end

  def handle_error_json(msg, http_code)
    logger.error("Hook (JSON) error handling, msg = #{msg}, HTTP code = #{http_code}")
    json({ error: msg }, http_code)
  end

  def standard_error_handle(exception, http_code = 400)
    case request.format
    when "text/html"
      handle_error_html(exception.message)
    when "text/json"
      handle_error_json(exception.message, http_code)
    else
      handle_error_json(exception.message, http_code)
    end
  end

  included do
    # errors from the API
    rescue_from RestClient::Exception do |e|
      case request.format
      when "text/html"
        handle_error_html(ExceptionHandler.stringify_rest_exception(e))
      when "text/json"
        handle_error_json(ExceptionHandler.stringify_rest_exception(e), e.http_code)
      else
        handle_error_json(ExceptionHandler.stringify_rest_exception(e), e.http_code)
      end
    end

    # otherwise:
    rescue_from StandardError do |e|
      standard_error_handle(e)
    end
  end
end
