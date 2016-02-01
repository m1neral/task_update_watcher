module TaskUpdateWatcher
  module IssueRelationsPatch
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        after_filter :controller_issue_relations_create, only: :create
        after_filter :controller_issue_relations_destroy, only: :destroy
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def controller_issue_relations_create
        SendData.new(@relation.issue_from.id, User.current.id).do if @relation.save
      end

      def controller_issue_relations_destroy
        SendData.new(@relation.issue_from.id, User.current.id).do if @relation
      end
    end
  end
end