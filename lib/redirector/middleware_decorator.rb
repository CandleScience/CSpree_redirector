Redirector::Middleware::Responder.class_eval do
  def redirect_uri
    destination_uri.tap do |uri|
      uri.scheme ||= 'https'
      uri.host   ||= request_host
      uri.port   ||= request_port if request_port.present?
      uri.query  ||= env['QUERY_STRING'] if Redirector.preserve_query
    end
  end
end