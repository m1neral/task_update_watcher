module TaskUpdateWatcher
  class TaskUpdateNotifier < Redmine::Hook::Listener
    def controller_issues_bulk_edit_before_save(context = {})
      SendData.new(context[:issue].id, User.current.id).do if context[:issue]
    end

    def controller_issues_edit_after_save(context = {})
      SendData.new(context[:issue].id, User.current.id).do if context[:issue]
    end

    def controller_journals_edit_post(context = {})
      SendData.new(context[:journal].issue.id, User.current.id).do if context[:journal]
    end

    def controller_issues_new_after_save(context = {})
      SendData.new(context[:issue].parent_issue_id, User.current.id).do if context[:issue].parent_issue_id
    end
  end
end