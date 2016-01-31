require 'data_sender'

module TaskUpdateWatcher
  class TaskUpdateNotifier < Redmine::Hook::Listener
    def controller_issues_bulk_edit_before_save(context = {})
      DataSender.send_data(context[:issue].id, User.current.id) if context[:issue]
    end

    def controller_issues_edit_after_save(context = {})
      DataSender.send_data(context[:issue].id, User.current.id) if context[:issue]
    end

    def controller_journals_edit_post(context = {})
      DataSender.send_data(context[:journal].issue.id, User.current.id) if context[:journal]
    end
  end
end