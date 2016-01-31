require 'net/http'
require 'uri'

module TaskUpdateWatcher
  class TaskUpdateNotifier < Redmine::Hook::Listener
    URL = 'http://httpbin.org/post'

    def controller_issues_bulk_edit_before_save(context = {})

    end

    def controller_issues_edit_after_save(context = {})

    end

    def controller_journals_edit_post(context = {})

    end
  end
end