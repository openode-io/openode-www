# Rack::Attack.blocklist_ip("::1")

Rack::Attack.throttle("requests by ip", limit: 500, period: 60) do |request|
  Rails.logger.info("Request throttle ip = #{request.ip}")
  request.ip
end

Rack::Attack.throttle('limit logins per ip', limit: 2, period: 60) do |req|
  if req.path == '/support' && req.post?
    Rails.logger.warn("limit logins per ip - Request throttled ip = #{req.ip}")
    req.ip
  end
end
