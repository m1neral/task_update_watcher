require 'net/http'
require 'uri'

module TaskUpdateWatcher
  class TaskUpdateNotifier < Redmine::Hook::Listener
    URL = 'http://httpbin.org/post'

    def controller_issues_bulk_edit_before_save(context = {})
      send_data(context[:issue].id, User.current.id) if context[:issue]
    end

    def controller_issues_edit_after_save(context = {})
      send_data(context[:issue].id, User.current.id) if context[:issue]
    end

    def controller_journals_edit_post(context = {})
      send_data(context[:journal].issue.id, User.current.id) if context[:journal]
    end

    private

    def send_data(issue_id, user_id)
      send_request issueid: issue_id, userid: user_id,
                   datetime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
    end

    def send_request(body)
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