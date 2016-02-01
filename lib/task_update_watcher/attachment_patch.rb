module TaskUpdateWatcher
  module AttachmentPatch
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        after_filter :controller_attachment_after_destroy, only: :destroy
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def controller_attachment_after_destroy
        SendData.new(@attachment.container.id, User.current.id).do if @attachment
      end
    end
  end
end