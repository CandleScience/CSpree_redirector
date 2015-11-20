require 'redirector'

Redirector::Middleware::Responder.class_eval do
  def response
    php_strip
    if redirect?
      redirect_response
    else
      app.call(env)
    end
  end

  def php_strip
    env['PATH_INFO'] = env['PATH_INFO'].gsub(/\.php\Z/, '')
  end

  def redirect?
    not_asset && matched_destination.present?
  end

  def not_asset
    !(env['PATH_INFO'] =~ /\A\/(assets|img|images)\//)
  end

  def redirect_uri
    destination_uri.tap do |uri|
      uri.scheme ||= (Rails.env.staging? || Rails.env.production?) ? 'https' : 'http'
      uri.host   ||= request_host
      uri.port   ||= request_port if request_port.present?
      uri.query  ||= env['QUERY_STRING'] if Redirector.preserve_query
    end
  end
end