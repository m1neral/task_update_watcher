require 'redmine'

require_dependency 'task_update_watcher/task_update_listener'
require_dependency 'task_update_watcher/attachment_patch'

Rails.application.config.to_prepare do
  AttachmentsController.send :include, TaskUpdateWatcher::AttachmentPatch
end

Redmine::Plugin.register :task_update_watcher do
  name 'Task Update Watcher plugin'
  author 'Anatoly Ryabov'
  description 'This is a plugin for Redmine, which send POST-request then some field of any issue is updated.'
  version '0.0.1'
  url 'https://github.com/m1neral/task_update_watcher'
  author_url 'https://github.com/m1neral'
end