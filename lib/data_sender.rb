require 'net/http'
require 'uri'

module TaskUpdateWatcher
  class DataSender
    URL = 'http://httpbin.org/post'

    def self.send_data(issue_id, user_id)
      send_request issueid: issue_id, userid: user_id,
                   datetime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
    end

    def self.send_request(body)
      uri = URI.parse URL
      http = Net::HTTP.new uri.host, uri.port
      request = Net::HTTP::Post.new uri.request_uri
      request['content-type'] = 'application/json'
      request.body = body.to_json
      http.request request
    rescue SocketError => e
      Rails.logger.error "Post request failed: #{e.inspect}; body: #{body.inspect}; uri: #{uri.inspect}"
    end
  end
end