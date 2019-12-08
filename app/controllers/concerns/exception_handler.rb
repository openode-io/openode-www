module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  def self.stringify_rest_exception(exception, http_code)
    case http_code
    when 401
      "Invalid credentials"
    else
      response = exception.try(:response)

      return exception.message unless response

      JSON.parse(response)['error']
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
    # msg = exception.try(:response).try(:message)
    msg = ExceptionHandler.stringify_rest_exception(exception, http_code)

    case request.format
    when "text/html"
      handle_error_html(msg)
    when "text/json"
      handle_error_json(msg, http_code)
    else
      handle_error_json(msg, http_code)
    end
  end

  included do
    rescue_from StandardError do |e|
      standard_error_handle(e, e.try(:http_code) || 400)
    end
  end
end
