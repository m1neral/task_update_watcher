require 'data_sender'

module TaskUpdateWatcher
  module IssueRelationsPatch
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        after_filter :controller_issue_relations_change, only: [:create, :destroy]
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def controller_issue_relations_change
        DataSender.send_data(@relation.issue_from.id, User.current.id) if @relation
      end
    end
  end
end