require 'net/http'
require 'uri'

module TaskUpdateWatcher
  class SendData
    attr_reader :data

    def initialize(issue_id, user_id)
      @data = { issueid: issue_id, userid: user_id }
    end

    def do
      send_request data.merge(default_data)
    end

    def request_url
      Setting.plugin_task_update_watcher['request_url']
    end

    private

    def send_request(body)
      uri = URI.parse request_url
      http = Net::HTTP.new uri.host, uri.port
      request = Net::HTTP::Post.new uri.request_uri
      request['content-type'] = 'application/json'
      request.body = body.to_json
      http.request request
    rescue SocketError => e
      Rails.logger.error "Post request failed: #{e.inspect}; body: #{body.inspect}; uri: #{uri.inspect}"
    end

    def default_data
      { datetime: Time.now.strftime('%Y-%m-%d %H:%M:%S') }
    end
  end
end